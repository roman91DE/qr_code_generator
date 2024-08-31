declare global {
    function qrcode(version: number, errorCorrectionLevel: string): QRCode;
}

export interface QRCode {
    addData(data: string): void;
    make(): void;
    createImgTag(cellSize: number): string;
}

export function createQRCode(version: number, errorCorrectionLevel: string): QRCode {
    return qrcode(version, errorCorrectionLevel);
}