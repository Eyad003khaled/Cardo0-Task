import { Injectable } from '@nestjs/common';
import { Reading } from './entities/reading.entity';
import { CreateReadingDto } from './dto/create-reading.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ReadingsService {

   constructor(private prisma: PrismaService) {}

  async create(data: { temperature: number; humidity: number }) {
    return this.prisma.reading.create({
      data,
    });
  }

  async getLatest() {
    return this.prisma.reading.findFirst({
      orderBy: { createdAt: 'desc' },
    });
  }


  // private readings: Reading[] = [];

  // create(dto: CreateReadingDto): Reading {
  //   const reading: Reading = {
  //     ...dto,
  //     createdAt: new Date(),
  //   };

  //   this.readings.push(reading);
  //   return reading;
  // }

  // findLatest(): Reading | null {
  //   if (this.readings.length === 0) return null;
  //   return this.readings[this.readings.length - 1];
  // }
}


