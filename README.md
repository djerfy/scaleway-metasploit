# Metasploit image on Scaleway

/!\ Sorry, this image is not success build, error occured on compile ruby and use gem for install the framework.

Scripts to build the **Metasploit** image on Scaleway.

This image is built using [Image Tools](https://github.com/scaleway/image-tools) and depends on the official [Debian Jessie](https://github.com/scaleway/image-debian) image.

![](http://cyberxsecurities.com/wp-content/uploads/2015/01/metasploit-logo.png)

---

**This image is meant to be used on a C1 server.**

We use the Docker's building system and convert it at the end to a disk image that will boot on real servers without Docker. Note that the image is still runnable as a Docker container for debug or for inheritance.

[More info](https://github.com/scaleway/image-tools)

---

## Require

Create and launch new server with **Image Builder** image. Create and attach new volume (/dev/ndb1) to server.

Connect on SSH and clone this repository for building image

    $ ssh root@xxx.xxx.xxx.xxx
    $ git clone https://github.com/djerfy/scaleway-metasploit.git

---

## Install

Build and write the image to /dev/ndb1 (see [documentation](https://www.scaleway.com/docs/create_an_image_with_docker/)).

Build can take a long time (compile ruby/nmap and install metasploit framework), take a coffee :)

    $ make install

Full list of commandes available at: [scaleway/images-tools](https://guthub.com/scaleway/image-tools/#commands)

---

