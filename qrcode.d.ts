declare function qrcode(version: number, errorCorrectionLevel: string): QRCode;

interface QRCode {
  addData(data: string): void;
  make(): void;
  createImgTag(cellSize: number): string;
}