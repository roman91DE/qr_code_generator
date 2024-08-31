const mockQRCode = {
  addData: jest.fn(),
  make: jest.fn(),
  createImgTag: jest.fn((cellSize) => {
    const size = cellSize * 21; // 21 is the size of the smallest QR code
    // This is a base64 encoded 1x1 pixel transparent PNG
    return `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==" width="${size}" height="${size}">`;
  })
};

global.qrcode = jest.fn(() => mockQRCode);

module.exports = global.qrcode;