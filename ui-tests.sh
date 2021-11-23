#!/bin/bash

start_test()
{
    set +e
    docker rm -f selenium-testsuite
    set -e
    docker pull devopsdojo/selenium-yb:latest
    docker create --name="selenium-testsuite" devopsdojo/selenium-yb:latest
    sed '1q;d' /tmp/data.txt | sed 's/8080/9967/1' | xargs -I 'my_arg' sed -i 's#http://petclinic#my_arg#' src/test/selenium-robot/resources/resource.robot
    sleep 2s
    docker cp src/test/selenium-robot/PetclinicTestCases selenium-testsuite:/home/robotframework/src/test/selenium-robot
    docker cp src/test/selenium-robot/resources selenium-testsuite:/home/robotframework/src/test/selenium-robot
    docker start -a selenium-testsuite
}

echo 'Invoking automated test cases in docker'
echo 'Create report directory' 
rm -rf report
mkdir report 
echo 'Start Tests'  
start_test
echo 'Copy test results report from docker container'
docker cp selenium-testsuite:home/robotframework/src/test/selenium-robot/output.xml report
docker cp selenium-testsuite:home/robotframework/src/test/selenium-robot/log.html report
docker cp selenium-testsuite:home/robotframework/src/test/selenium-robot/report.html report
