# habitat-jenkins

This is a plan to run jenkins in habitat via the `.war` file.

## Build instructions

```
$ hab studio enter # enter the studio
[1][default:/src:0]# cd habitat-jenkins/
[2][default:/src/habitat-jenkins:0]# build
[3][default:/src/habitat-jenkins:0]# hab start YOURORIGIN/jenkins-war # verify everything comes up
[4][default:/src/habitat-jenkins:0]# hab pkg export docker YOURORIGIN/jenkins-war # export to a container
[5][default:/src/habitat-jenkins:0]# logout # leave the studio
$ docker run -p 8080:8080 -it YOURORIGIN/jenkins-war:latest # run container
```

## Backups

This plan also packages a [S3 backup script](https://github.com/artsy/jenkins-backup-s3) with a Python virtualenv for backing up your Jenkins config.

To use it, set up a cron job or a Jenkins job to run:

```
source $(hab pkg path mozillareality/jenkins-war)/bin/activate
python3 $(hab pkg path mozillareality/jenkins-war)/bin/backup-s3 --bucket <your-bucket> --region <bucket-region> create --jenkins-home /hab/svc/jenkins-war/data
```

## License & Authors

- Author:: JJ Asghar (<jj@chef.io>)
- Author:: Ian Henery (<ihenery@chef.io>)
- Author:: Elliott Davis (<edavis@chef.io>)
- Author:: Greg Fodor (<gfodor@mozilla.com>)

```text
Copyright (c) 2016, JJ Asghar

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
