ARG UBUNTU_RELESE=noble
ARG MANYPYTHON_BASE_IMAGE=manypython-base

FROM $MANYPYTHON_BASE_IMAGE:$UBUNTU_RELESE

LABEL dev.containers.features="common"

ARG UBUNTU_RELESE
RUN if [ "$UBUNTU_RELESE" = "noble" ]; then \
        if id "ubuntu" &>/dev/null; then \
            echo "Deleting user 'ubuntu'  for $UBUNTU_RELESE" && userdel -f -r ubuntu || echo "Failed to delete ubuntu user for $UBUNTU_RELESE"; \  
        else \
            echo "User 'ubuntu' does not exist for $UBUNTU_RELESE"; \ 
        fi; \
    fi

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
