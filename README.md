# Alfresco SDK Upgrader

This is a DevCon 2019 Hack-a-Thon project aimed at automating the upgrade of
Alfresco SDK 3.0.1 projects to SDK 4.0.0.

## Running

From the root of the alfresco-sdk-upgrader directory, run ./upgrade.sh. When
prompted, specify the directory where your 3.0.1 project lives. The script will
then begin the upgrade process.

## Tips

The script backs up your old project to a hidden backup directory relative to
the root of the alfresco-sdk-upgrader project. If you need to recover the state
of your project as it was before the upgrade, check there.

The script also generates a pristine 4.0.0 project in a hidden directory that is
used as a source to grab files from.

## To Do

* Add windows support. The script currently runs on Linux and MacOS. It uses no
native libraries so it should be relatively straightforward to write an
upgrade.bat script for Windows.
* Maintain original dependencies. Currently, if the project being upgraded has
its own dependencies, the script will not bring them over. It would be nice to
bring those over so they don't have to be merged manually.
* Add support for repo-only or Share-only projects. Currently, the script only
supports the all-in-one project. It would be nice to add support for projects
created from other archetypes.
