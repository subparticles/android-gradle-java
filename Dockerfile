FROM subparticles/sdk-builder-base:latest

RUN sdk update
RUN sdk install java 11.0.12-zulu
RUN sdk install gradle 7.0.2

USER root
RUN curl -L https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip -o commandlinetools-linux.zip
RUN mkdir -p /opt/Android/Sdk
RUN unzip -o -q commandlinetools-linux.zip -d /opt/Android/Sdk/cmdline-tools
RUN mv /opt/Android/Sdk/cmdline-tools/cmdline-tools /opt/Android/Sdk/cmdline-tools/tools

RUN chown -R user:user /opt/Android

ENV ANDROID_HOME=/opt/Android/Sdk
ENV ANDROID_SDK_ROO=$ANDROID_HOME
ENV PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

USER user
RUN yes | sdkmanager --licenses
RUN sdkmanager --update
RUN sdkmanager --install "platforms;android-30" "build-tools;30.0.2" "extras;google;m2repository" "extras;android;m2repository"
RUN sdkmanager --install "platform-tools"
