# upgrade: github cryptpad/cryptpad
ARG CRYPTPAD_VERSION=2026.10.1
FROM cryptpad/cryptpad:version-${CRYPTPAD_VERSION}

# Docs, Sheets and Slides. Baked in so a redeploy never downloads 600 MB again.
RUN ./install-office.sh --accept-license --trust-repository

USER root
COPY config.js infra.js railway-entrypoint.sh /railway/
RUN chmod +x /railway/railway-entrypoint.sh

ENV CRYPTPAD_CONFIG=/railway/config.js CRYPTPAD_CONFIG_INFRA=/railway/infra.js
ENTRYPOINT ["/railway/railway-entrypoint.sh"]
CMD []
