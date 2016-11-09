# One and done

Your mission, should you choose to accept it, is to create a single script that takes a brand new VM, and creates a fully-functioning production site, all by running a single command. In other words, setup should not require `vagrant ssh`, or any other interaction.

## Workflow

1. Modify [`provision.sh`](provision.sh), etc.
1. Run `vagrant up`.
    * As you can see in the [`config.vm.provision`](https://www.vagrantup.com/docs/provisioning/) command in the [`Vagrantfile`](Vagrantfile), this will run [`provision.sh`](provision.sh) after the VM is created.
1. Visit your VM's IP in your browser, and you should see "Hello world!"
1. If that doesn't work, run a `vagrant destroy` and repeat from step 1.

This turnaround time is slow, so you might want to run the commands by hand within `vagrant ssh`, then move them into the provisioning script as you finalize them.

## Tutorials

These may help:

* http://exploreflask.com/en/latest/deployment.html
* https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-16-04

## Tips

* There are [a lot](http://flask.pocoo.org/docs/0.11/deploying/) of Python WSGI web server options. Unless you specifically want to try a different one, go with [Gunicorn](http://docs.gunicorn.org/) (pronounced "G-unicorn").
* You need to [reload nginx configuration](http://nginx.org/en/docs/beginners_guide.html#control) after you modify it for the changes to be picked up.
* The [vagrant-address](https://github.com/mkuzmin/vagrant-address) plugin is useful for getting the IP address of your VM.

## Next steps

Once you get the above working locally:

1. Use Vagrant to deploy the site to Amazon Web Services (AWS)
    * *Be very careful not to commit your AWS credentials to the repository.*
1. Run the site in a Docker container

## Discussion questions

* What is the point of this exercise?
* What is each command in your provisioning script doing?
* How can you verify that each command is doing what you intend for it to? In other words, how would you test/troubleshoot this?
* Why do we need nginx, Gunicorn, etc? Why not just use `flask run`?
