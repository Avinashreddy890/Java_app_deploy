# Build stage
FROM openjdk:21-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy source files
COPY src/ ./src/

# Create output directory
RUN mkdir -p out

# Compile Java files
RUN find src -name "*.java" > sources.txt && javac -d out @sources.txt

# Copy resources to output directory
RUN cp -r src/resources out/

# Runtime stage
FROM openjdk:21-jdk-slim

# Set working directory for runtime
WORKDIR /app

# Copy compiled classes and resources from build stage
COPY --from=build /app/out /app/out

# Set working directory to compiled output
WORKDIR /app/out

# Command to run the application
CMD ["java", "com.zetcode.Snake"]