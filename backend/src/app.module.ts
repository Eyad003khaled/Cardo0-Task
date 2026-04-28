import { Module } from '@nestjs/common';
import { ReadingsModule } from './readings/readings.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [PrismaModule, ReadingsModule],
})
export class AppModule {}