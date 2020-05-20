properties([
    parameters ([
        string(name: 'BUILD_NODE', defaultValue: 'omar-build', description: 'The build node to run on'),
        string(name: 'OSSIM_BRANCH', defaultValue: 'dev', description: 'The branch to use for ossim'),
        string(name: 'OSSIM_PLUGINS_BRANCH', defaultValue: 'dev', description: 'The branch to use for ossim plugins'),
        string(name: 'OSSIM_OMS_BRANCH', defaultValue: 'dev', description: 'The branch to use for ossim oms'),
        string(name: 'OSSIM_VIDEO_BRANCH', defaultValue: 'dev', description: 'The branch to use for ossim video'),
        string(name: 'OSSIM_DEEPCORE_BRANCH', defaultValue: 'dev', description: 'The branch to use for ossim deepcore'),
        booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Clean the workspace at the end of the run')
    ]),
    pipelineTriggers([
            [$class: "GitHubPushTrigger"]
    ]),
    [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ossimlabs/ossim-centos-minimal.git'],
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '3', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds()
])

timeout(time: 60, unit: 'MINUTES') {
    node("${BUILD_NODE}"){

        stage("Checkout")
        {
            checkout(scm)
        }

        stage("Load Variables")
        {
            withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
                step ([$class: "CopyArtifact",
                    projectName: o2ArtifactProject,
                    filter: "common-variables.groovy",
                    flatten: true])
            }

            load "common-variables.groovy"
        }

        stage ("Checkout Source Code") 
        {                          
            dir("compile-ossim"){
                sh "./checkout-ossim.sh"
            }
        }  

        stage ("Build Ossim")
        {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: "https://${DOCKER_REGISTRY_DOWNLOAD_URL}") {
                dir("compile-ossim") {
                    sh """
                        export BUILDER_IMAGE="${DOCKER_REGISTRY_DOWNLOAD_URL}/ossim-builder-minimal-centos:\$(cat ../version.txt)"
                        ./build.sh
                    """
                    archiveArtifacts "output/ossim-dist-minimal-centos.tgz"
                }
            }
        }

        stage ("Build Runtime Image")
        {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: "https://${DOCKER_REGISTRY_DOWNLOAD_URL}") {
                dir("runtime") {
                    sh "./build-docker.sh"
                }
            }
        }

        stage ("Publish Docker Image")
        {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: "https://${DOCKER_REGISTRY_PRIVATE_UPLOAD_URL}") {
                sh """
                    docker tag ossim-runtime-minimal-centos:local ${DOCKER_REGISTRY_PRIVATE_UPLOAD_URL}/ossim-runtime-minimal-centos:${OSSIM_BRANCH}
                    docker push ${DOCKER_REGISTRY_PRIVATE_UPLOAD_URL}/ossim-runtime-minimal-centos:${OSSIM_BRANCH}
                """
            }
        }

        stage("Clean Workspace")
        {
            if ("${CLEAN_WORKSPACE}" == "true")
                step([$class: 'WsCleanup'])
        }
    }
}
