import { Injectable } from '@nestjs/common';
import { Reading } from './entities/reading.entity';
import { CreateReadingDto } from './dto/create-reading.dto';

@Injectable()
export class ReadingsService {
  private readings: Reading[] = [];

  create(dto: CreateReadingDto): Reading {
    const reading: Reading = {
      ...dto,
      createdAt: new Date(),
    };

    this.readings.push(reading);
    return reading;
  }

  findLatest(): Reading | null {
    if (this.readings.length === 0) return null;
    return this.readings[this.readings.length - 1];
  }
}