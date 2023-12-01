export class Segment {
  constructor(id) {
    this.id = id;
    this.x = 0;
    this.y = 0;
  }

  xy() {
    return this.x + "," + this.y;
  }
}
