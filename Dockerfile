FROM alpine:latest

ARG TARGETARCH
RUN echo TARGETARCH is: $TARGETARCH

RUN apk add --no-cache \
    curl \
    bash

# Install tools
ENV VERIFY_CHECKSUM=false
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh \
    && ./get_helm.sh

RUN curl -fsSL -o kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.3.0/kustomize_v5.3.0_linux_${TARGETARCH}.tar.gz \
    && tar -xzvf kustomize.tar.gz \
    && chmod +x kustomize \
    && mv kustomize /usr/local/bin/

RUN rm -rf get_helm.sh kustomize.tar.gz

CMD ["bash"]