# SharePoint Framework Docker images

A lightweight Docker image for running [SharePoint Framework](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/sharepoint-framework-overview).

## Usage

- Create a folder for your SharePoint Framework project

```sh
cd [your project]
docker run -itd --rm --name docker-spfx -v ${PWD}:/home/spfx/app -p 5432:5432 -p 4321:4321 -p 35729:35729 luckyjc/spfx:1.4.1

```

Once the container started, execute the command below to create a new SPFx project in the container and follow the prompts:

```sh
yo @microsoft/sharepoint
```

To open the SharePoint workbench navigate in the browser to **https://localhost:5432/workbench**.

All files created by the generator will be saved in your project directory on your host where you can commit them to source control.

**Note you will have a detached Docker process running this container after you close the terminal that you can stop by running `docker stop <container-id>`.

## Versions
spfx:1.4.1 is the image used to develop against on-premise SharePoint Server 2019

## Known issues

If you get a browser warning that the connection isn't private and localhost is untrusted; NET:ERR_CERT_AUTHORITY_INVALID

You need to run `gulp trust-dev-cert` within the container to create the certificate.

If you are using Visual Studio code for remote development, a Download command is available from the palette (Ctrl+Shift+P) or when right-clicking on a file. We need to include the .cer file in the explorer view. The following command will copy the .cer file from its generated location into the workspace folder.

`cp /home/spfx/.gcb-serve-data/*.cer .`
	
    ** This will put a copy of the certificate in the root project file. You will want to delete this file after you download it to prevent accidentally checking it into source.
    
If using Windows, you then need to trust the certificate

With the file on the local computer, we can add it to the correct certificate store using the same command as the SPFx toolchain. 

For Windows, the command:

`certutil -user -addstore root <path-to-cer-file>`

When running `yo @microsoft/sharepoint` you get an error that the container is unable to write files to the disk. In most cases this is caused by the drive not being shared in Docker. Go to Docker > Settings > Sharing to enable sharing the drive where your project is located.