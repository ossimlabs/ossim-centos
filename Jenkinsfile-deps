properties([
    parameters ([
        string(name: 'BUILD_NODE', defaultValue: 'omar-build', description: 'The build node to run on'),
        booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Clean the workspace at the end of the run')
    ]),
    pipelineTriggers([
            [$class: "GitHubPushTrigger"]
    ]),
    [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ossimlabs/ossim-centos-minimal.git'],
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '3', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds()
])

timeout(time: 90, unit: 'MINUTES') {
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

        stage ("Checkout Dependencies Source Code") 
        {                          
            dir("builder-image"){
                sh "./checkout-scripts/checkout-deps.sh"
            }
        }

        stage ("Create Builder Image") {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: "https://${DOCKER_REGISTRY_DOWNLOAD_URL}") {
                dir("builder-image"){
                    sh "./build.sh"
                }
            }
        }

        stage ("Push Builder Image") {
            withDockerRegistry(credentialsId: 'dockerCredentials', url: "https://${DOCKER_REGISTRY_PRIVATE_UPLOAD_URL}") {
                sh """
                    docker tag ossim-builder-minimal-centos:local ${DOCKER_REGISTRY_PRIVATE_UPLOAD_URL}/ossim-builder-minimal-centos:\$(cat version.txt)
                    docker push ${DOCKER_REGISTRY_PRIVATE_UPLOAD_URL}/ossim-builder-minimal-centos:\$(cat version.txt)
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
