import { Controller, Get, Post, Body } from '@nestjs/common';
import { ReadingsService } from './readings.service';
import { CreateReadingDto } from './dto/create-reading.dto';

@Controller('readings')
export class ReadingsController {
  constructor(private readonly service: ReadingsService) {}

  // @Post()
  // create(@Body() dto: CreateReadingDto) {
  //   return this.service.create(dto);
  // }

  // @Get('latest')
  // findLatest() {
  //   return this.service.findLatest();
  // }

  @Post()
create(@Body() body: any) {
  return this.service.create(body);
}

@Get('latest')
getLatest() {
  return this.service.getLatest();
}
}
