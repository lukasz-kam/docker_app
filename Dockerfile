FROM python:3.12.11-alpine3.22

WORKDIR /app

COPY  /app /app

COPY /app/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD python healthcheck.py || exit 1

ENTRYPOINT ["entrypoint.sh"]