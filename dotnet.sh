dotnet add package Serilog 
dotnet add package Serilog.AspNetCore 
dotnet add package Serilog.Enrichers.ClientInfo 
dotnet add package Serilog.Enrichers.CorrelationId 
dotnet add package Serilog.Enrichers.Environment 
dotnet add package Serilog.Enrichers.Process 
dotnet add package Serilog.Enrichers.Sensitive 
dotnet add package Serilog.Enrichers.Thread 
dotnet add package Serilog.Exceptions 
dotnet add package Serilog.Formatting.Compact 
dotnet add package Serilog.Sinks.Console 
dotnet add package Serilog.Sinks.File 
dotnet add package Serilog.Sinks.RollingFile 
dotnet add package Microsoft.AspNet.WebApi.Client
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Newtonsoft.Json
dotnet add package NUnit
dotnet add package AutoMapper
dotnet add package Swashbuckle
dotnet add package MediatR

dotnet add MyWebApp.Web.csproj reference ..\MyWebApp.Core\MyWebApp.Core.csproj
dotnet add .\MyWebApp.Client\MyWebApp.Client.csproj reference .\MyWebApp.DataStore\MyWebApp.DataStore.csproj
dotnet new mvc -o MyWebApp.Client
dotnet new classlib -o MyWebApp.DataStore
dotnet new mstest -o MyWebApp.DataStoreTest
dotnet run -p .\MyWebApp.Client\MyWebApp.Client.csproj
dotnet sln MyWebApp.sln add .\MyWebApp.Client\MyWebApp.Client.csproj .\MyWebApp.DataStore\MyWebApp.DataStore.csproj .\MyWebApp.DataStoreTest\MyWebApp.DataStoreTest.csproj
dotnet test .\MyWebApp.DataStoreTest\MyWebApp.DataStoreTest.csproj
dotnet watch run

dotnet tool install -g dotnet-ef
dotnet tool update -g dotnet-ef

dotnet ef -h
dotnet ef database update --project <PersistenceProjectPath> 
dotnet ef database update --project <PersistenceProjectPath> --startup-project <StartupProjectPath> --context <DbContextName> --connection <ConnectionString>
dotnet ef migrations add <MigrationName> --project <PersistenceProjectPath>
dotnet ef dbcontext scaffold "Server=.\;Database=AdventureWorksLT2012;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -o <OutputFolderName>

dotnet tool install -g AWS.CodeArtifact.NuGet.CredentialProvider
dotnet codeartifact-creds install
dotnet codeartifact-creds configure set profile <aws-iam-profile>
dotnet pack
dotnet nuget push Donohue.DevOps.Utilities.1.0.0.nupkg --source <code-artifact-domain>/nuget
dotnet nuget add source "https://<code-artifact-domain>-<aws-account-id>.d.codeartifact.us-east-1.amazonaws.com/nuget/nuget/v3/index.json" -n "<code-artifact-domain>/nuget"
dotnet add package Donohue.DevOps.Utilities --source "<code-artifact-domain>/nuget"
aws codeartifact login --region us-east-1 --tool dotnet --domain <code-artifact-domain> --domain-owner <aws-account-id> --repository nuget
nuget locals all -clear