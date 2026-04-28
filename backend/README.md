# Backend - NestJS REST API

## Overview

The backend is a **NestJS-based REST API server** that receives sensor data from the ESP32, stores it in PostgreSQL via Prisma ORM, and serves the latest readings to the mobile application.

## What This Component Does

- **Accepts sensor readings** via HTTP POST from ESP32 device
- **Stores data** in PostgreSQL database with automatic timestamps
- **Provides API endpoints** for the mobile app to fetch the latest reading
- **Manages database schema** using Prisma migrations
- **Handles errors** with proper HTTP status codes and error responses

## Core Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/readings` | Store a new temperature/humidity reading |
| GET | `/readings/latest` | Fetch the most recent sensor reading |

## Architecture

```
src/
├── app.module.ts              # Root module
├── main.ts                    # Application entry point
├── prisma/
│   ├── prisma.module.ts       # Database module
│   └── prisma.service.ts      # Database connection service
└── readings/
    ├── readings.controller.ts # HTTP endpoints
    ├── readings.service.ts    # Business logic
    ├── readings.module.ts     # Feature module
    ├── dto/                   # Request validation
    └── entities/              # Response models
```

## Key Technologies

- **Framework**: NestJS 11.0.1
- **Language**: TypeScript
- **Database**: PostgreSQL (Supabase Cloud) with Prisma ORM 5.22.0
- **Runtime**: Node.js 18+
- **API Protocol**: HTTP/REST with JSON

## Database Schema

```prisma
model Reading {
  id          Int      @id @default(autoincrement())
  temperature Float
  humidity    Float
  createdAt   DateTime @default(now())
}
```

## Database Layer

This project uses **Supabase (cloud PostgreSQL)** as the managed database provider.

- Provides hosted PostgreSQL instance
- Handles scaling and backups automatically
- Fully compatible with Prisma ORM
- Used as the central storage for all sensor readings



### Design Rationale
- **Auto-incrementing ID**: Simple and efficient for ordering
- **Float precision**: Accommodates sensor decimal values (e.g., 25.5°C)
- **Immutable records**: No updates; data is write-once for audit trail
- **Timestamps**: Enables time-series analysis and sorting

## Request & Response Examples

### Create Reading (POST /readings)

**Request:**
```json
{
  "temperature": 25.5,
  "humidity": 60.0
}
```

**Response (201 Created):**
```json
{
  "id": 42,
  "temperature": 25.5,
  "humidity": 60.0,
  "createdAt": "2026-04-28T10:30:46.123Z"
}
```

### Get Latest Reading (GET /readings/latest)

**Response (200 OK):**
```json
{
  "id": 42,
  "temperature": 25.5,
  "humidity": 60.0,
  "createdAt": "2026-04-28T10:30:46.123Z"
}
```

## Module Organization

### Prisma Module
- Handles database connection lifecycle
- Exposed as injectable `PrismaService` for type-safe queries
- Automatically connects on module initialization

### Readings Module
- **Controller**: Routes HTTP requests to service methods
- **Service**: Implements business logic (`create()`, `getLatest()`)
- **DTO**: Defines request payload structure
- **Entity**: Defines response model

## Error Handling

| Scenario | Response |
|----------|----------|
| Invalid request | 400 Bad Request |
| Server error | 500 Internal Server Error |
| Invalid data type | 400 Bad Request |

## Available npm Scripts

```bash
npm run build          # Compile TypeScript to JavaScript
npm run start          # Start server
npm run start:dev      # Start with auto-reload (watch mode)
npm run start:prod     # Production build and start
npm run lint           # Lint and fix code
npm run format         # Format code with Prettier
npm run test           # Run unit tests
npm run test:e2e       # Run end-to-end tests
```

## Environment Variables

Create a `.env` file in the backend root:

```
DATABASE_URL="postgresql://user:password@localhost:5432/cardoo_db"
PORT=3000
NODE_ENV=development
```

## Dependency Injection Pattern

The backend uses NestJS built-in dependency injection:

```typescript
// Prisma service is automatically injected
export class ReadingsService {
  constructor(private prisma: PrismaService) {}
  
  async create(data: { temperature: number; humidity: number }) {
    return this.prisma.reading.create({ data });
  }
}
```

Benefits:
- Loose coupling between layers
- Easy to test with mocked dependencies
- Centralized dependency management

## Integration Points

- **Input**: HTTP POST requests from ESP32 (`http://backend:3000/readings`)
- **Output**: JSON responses to mobile app (`GET /readings/latest`)
- **Storage**: PostgreSQL database (Prisma client)

---

**Part of**: Cardoo IoT System  
**Created**: April 2026

## Run tests

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Deployment

When you're ready to deploy your NestJS application to production, there are some key steps you can take to ensure it runs as efficiently as possible. Check out the [deployment documentation](https://docs.nestjs.com/deployment) for more information.

If you are looking for a cloud-based platform to deploy your NestJS application, check out [Mau](https://mau.nestjs.com), our official platform for deploying NestJS applications on AWS. Mau makes deployment straightforward and fast, requiring just a few simple steps:

```bash
$ npm install -g @nestjs/mau
$ mau deploy
```

With Mau, you can deploy your application in just a few clicks, allowing you to focus on building features rather than managing infrastructure.

## Resources

Check out a few resources that may come in handy when working with NestJS:

- Visit the [NestJS Documentation](https://docs.nestjs.com) to learn more about the framework.
- For questions and support, please visit our [Discord channel](https://discord.gg/G7Qnnhy).
- To dive deeper and get more hands-on experience, check out our official video [courses](https://courses.nestjs.com/).
- Deploy your application to AWS with the help of [NestJS Mau](https://mau.nestjs.com) in just a few clicks.
- Visualize your application graph and interact with the NestJS application in real-time using [NestJS Devtools](https://devtools.nestjs.com).
- Need help with your project (part-time to full-time)? Check out our official [enterprise support](https://enterprise.nestjs.com).
- To stay in the loop and get updates, follow us on [X](https://x.com/nestframework) and [LinkedIn](https://linkedin.com/company/nestjs).
- Looking for a job, or have a job to offer? Check out our official [Jobs board](https://jobs.nestjs.com).

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://twitter.com/kammysliwiec)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](https://github.com/nestjs/nest/blob/master/LICENSE).
