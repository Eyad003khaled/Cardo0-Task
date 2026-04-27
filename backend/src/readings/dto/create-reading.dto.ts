export class CreateReadingDto {
  temperature: number;
  humidity: number;

  constructor(temp: number, hum: number) {
    this.temperature = temp;
    this.humidity = hum;
  }
}