# Stage 1: Build
FROM node:18-alpine as build

WORKDIR /app

# Menyalin semua file ke dalam container
COPY . /app

# Install dependencies
RUN npm install

# Install npm terbaru (jika diperlukan)
RUN npm install npm@latest -g

# Stage 2: Final image with Puppeteer support
FROM buildkite/puppeteer:latest

WORKDIR /app

# Menyalin file yang sudah diinstal dari stage build sebelumnya
COPY --from=build /app /app

# Install dependencies jika diperlukan (jika ada file package-lock.json)
RUN npm install

# Menjalankan aplikasi
CMD ["npm", "start"]

# Expose port yang digunakan aplikasi
EXPOSE 8080
