FROM cirrusci/flutter:stable

RUN useradd -ms /bin/bash flutteruser

WORKDIR /app

COPY . .

RUN chown -R flutteruser:flutteruser /app

RUN git config --global --add safe.directory /sdks/flutter && \
    chown -R flutteruser:flutteruser /sdks/flutter

USER flutteruser

RUN flutter pub get

# Запускаем приложение
CMD ["flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "8080"]
