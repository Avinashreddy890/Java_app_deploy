# Build stage
FROM openjdk:21-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy source files into container
COPY src/ ./src/

# Create output directory for compiled classes
RUN mkdir -p out

# Compile Java files, listing all .java files into sources.txt
RUN find src -name "*.java" > sources.txt \
    && javac -d out @sources.txt

# Copy resources (images) into compiled output directory
RUN cp -r src/resources out/

# Runtime stage
FROM openjdk:21-jdk-slim

# Set working directory for runtime
WORKDIR /app

# Copy compiled classes and resources from build stage
COPY --from=build /app/out /app/out

# Set working directory to compiled output
WORKDIR /app/out

# Expose a port (optional if your app uses network — but not needed for Snake game unless it's a server app)
# EXPOSE 8080

# Command to run the Java application
CMD ["java", "com.zetcode.Snake"]