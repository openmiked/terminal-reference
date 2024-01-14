#--- Swagger --> Angular Code Generator ---#
cd <angular_app_dir>
npm install ng-swagger-gen --save-dev
node_modules/.bin/ng-swagger-gen
ng-swagger-gen -i 127.0.0.1/swagger/doc.json -o ~/output-dir
ng-swagger-gen -i ~/swagger/doc.json -o ~/output-dir

#--- NUnit3 CLI Tool ---#
nunit3-console ~/my-app.dll --result:UnitTestResults_20200101.xml

#--- EventStore:  Local Instance CLI ---#
EventStore.ClusterNode --db ./db --log ./logs

#--- Keycloak ---#
export KC_HTTP_PORT=8081
/opt/keycloak/bin/kc.sh export --realm donohue-core --file /opt/keycloak/data/export/donohue-core.json --users realm_file
