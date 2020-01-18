@Library('lib') _
pipeline {
  agent any
  environment  {
      COMMIT_FILE = "$WORKSPACE/data.tx"
      FILE_ARCHIVE = "/files/jenkins_dir/builds/honeypot/"
      GIT_CREDENCIALS_ID = 'Gitlab'
      GIT_PULL_URL = 'git@gitlab.com:manorivile/mr-honeypot.git'
      DOCKER_REPOSITORY = "manorivile/rivile-project:"
      DOCKER_LOGIN = "dockerhub"
      DOCKER__REPOSITORY = ""
  }
//  parameters {
//     choice(choices: getDeclared('front'), description: '', name: 'app')
//     string(defaultValue: '', description: 'This is prefix for image name used in tag. Suports a-z,A-Z, "-_."', name: 'version', trim: false)
//     booleanParam(defaultValue: false, description: 'Select to build base image to add new libraries.', name: 'dependencyBuild')
//     string(defaultValue: 'master', description: '', name: 'branch', trim: false)
//   }
    stages {
        stage('application copy') {
            steps {
                script {
                          env.DOCKERFILE = getDeclared('honeypot', params.app, "build", "dockerfile")
                          env.APPLICATION = params.app
                          env.BUILD_DIR = getDeclared('honeypot', params.app, "build", "builddir")
                          env.PROJECT_DIR = getDeclared('honeypot', params.app, "build", "dir")
                }
            }
        }
        stage('check conkurent build') {
            steps {
                script { env.BUILD_TAG = ((params.version.trim().equals("")) ? BuildHelper.version(env.APPLICATION,env.BUILD_NUMBER) : (env.APPLICATION+params.version))}
                script { env.BUILD_IMAGE = env.DOCKER_REPOSITORY + ((params.version.trim().equals("")) ? BuildHelper.version(env.APPLICATION,env.BUILD_NUMBER) : (env.APPLICATION+params.version))}
                script {
                    def thisBuild = BuildHelper.with(this, env.FILE_ARCHIVE)
                    thisBuild.prepareBuildInfo(env.APPLICATION, env.BUILD_TAG, env.BUILD_IMAGE, env.COMMIT_FILE)
                }
            }
        }
        stage('build microservice') {
            steps {
            	script{ currentBuild.description = "Building microservice: " + env.APPLICATION + "\n" }
                script{ currentBuild.description += "Build image: " + env.BUILD_IMAGE + "\n"  }
            	sh "pwd"
            	sh "ls -la"
            	echo "BASE_IMAGE_TAG: $BASE_IMAGE_TAG, DOCKERFILE: $DOCKERFILE, BUILD_IMAGE: $BUILD_IMAGE, BUILD_DIR: $BUILD_DIR"
                   
                script {
                		dockerBuild(env.DOCKER__REPOSITORY, env.DOCKER_LOGIN,  env.BUILD_IMAGE,  env.DOCKERFILE, env.BUILD_DIR)
                }
            }
        }
    }
}
