let lastGeneratedText: string = '';
let cachedDataURL: string | null = null;

function generateQR(): void {
    console.log("generateQR function called");
    const textInput = document.getElementById("text-input") as HTMLInputElement;
    const text = textInput.value;
    console.log("Input text:", text);

    if (text) {
        console.log("Creating QR code");
        const qr = qrcode(0, "M");
        qr.addData(text);
        qr.make();
        const qrCodeDiv = document.getElementById("qr-code");
        if (qrCodeDiv) {
            console.log("Setting QR code HTML");
            const qrImageTag = qr.createImgTag(5);
            qrCodeDiv.innerHTML = qrImageTag;
            
            // Extract and cache the data URL
            cachedDataURL = qrImageTag.match(/src="([^"]+)"/)?.[1] || null;
            
            lastGeneratedText = text;
            showDownloadOptions();
        } else {
            console.error("QR code div not found");
        }
    } else {
        console.log("No text entered");
        alert("Please enter some text or URL");
    }
}

function showDownloadOptions(): void {
    const downloadOptions = document.getElementById("download-options");
    if (downloadOptions) {
        downloadOptions.style.display = "block";
    }
}

function downloadQRCode(format: string): void {
    if (cachedDataURL) {
        const link = document.createElement("a");
        link.download = `qr-code.${format}`;
        link.href = cachedDataURL;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    } else {
        console.error("No QR code data available for download");
        alert("Please generate a QR code first before downloading");
    }
}

// Wait for the DOM to be fully loaded before adding event listeners
document.addEventListener("DOMContentLoaded", () => {
    console.log("DOM content loaded");
    
    const generateButton = document.getElementById("generate-button");
    if (generateButton) {
        console.log("Adding click event listener to generate button");
        generateButton.addEventListener("click", generateQR);
    } else {
        console.error("Generate button not found");
    }

    const downloadPNGButton = document.getElementById("download-png");
    if (downloadPNGButton) {
        console.log("Adding click event listener to PNG download button");
        downloadPNGButton.addEventListener("click", () => downloadQRCode("png"));
    }

    const downloadJPGButton = document.getElementById("download-jpg");
    if (downloadJPGButton) {
        console.log("Adding click event listener to JPG download button");
        downloadJPGButton.addEventListener("click", () => downloadQRCode("jpg"));
    }
});
