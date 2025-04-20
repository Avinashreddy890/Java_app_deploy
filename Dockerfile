# Use an OpenJDK base image
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project to the container
COPY . .

# Create a directory for compiled classes
RUN mkdir -p out

# Compile the Java source files
RUN javac -d out src/com/zetcode/*.java

# Copy resources into the out directory so the app can access them at runtime
RUN cp -r resources out/

# Set working directory to the compiled output
WORKDIR /app/out

# Expose port if needed (not mandatory for a desktop-like app, unless you're serving it over RMI/sockets)
# EXPOSE 8080

# Command to run the application (assuming Snake.java has the main method)
CMD ["java", "com.zetcode.Snake"]