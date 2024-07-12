# This Dockerfile is used where you need to create a custom workshop base
# image which incorporates additional application binaries or tools. Select
# the appropriate Educates workshop base image in the `FROM` line.

FROM ghcr.io/vmware-tanzu-labs/educates-base-environment:2.6

# Include here any steps to build your custom workshop base image. See the
# documentation on best practices for building a custom workshop base image.

USER root

RUN yum -y install wget

RUN wget -O imgpkg https://github.com/vmware-tanzu/carvel-imgpkg/releases/latest/download/imgpkg-linux-amd64

RUN chmod +x imgpkg

RUN sudo mv imgpkg /usr/local/bin/

RUN imgpkg pull -i ghcr.io/vmware-tanzu-labs/educates-client-programs:develop -o educates-client-programs

RUN cp educates-client-programs/educates-linux-amd64 educates

RUN chmod +x educates

RUN sudo mv educates /usr/local/bin/

# Uncomment the following if you wish to also copy workshop content files
# into the custom workshop base image, rather than workshop content files
# being published using a separate OCI image artefact or other mechanism.

COPY --chown=1001:0 . /home/eduk8s/
RUN mv /home/eduk8s/workshop /opt/workshop
RUN fix-permissions /home/eduk8s
USER 1001


