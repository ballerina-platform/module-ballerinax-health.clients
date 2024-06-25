import ballerina/io;
import ballerina/tcp;

# DICOM TCP client wrapper
isolated client class DicomTcpClient {

    private tcp:Client? tcpClient;
    private boolean isConnected;
    private byte[] & readonly receivedBytes;
    private final io:ReadableByteChannel byteChannel;

    function init() returns error? {
        self.tcpClient = ();
        self.isConnected = false;
        self.receivedBytes = [];
        // Create a readable byte channel from the received bytes
        self.byteChannel = check io:createReadableChannel(self.receivedBytes);
    }

    remote function connect(TransportConnect primitive) returns error? {
        if self.getIsConnected() {
            return error("Already connected to a remote server");
        }
        self.setTcpClient(check new (primitive.address, primitive.port));
        self.setIsConnected(true);
    }

    remote function receive(int nBytes) returns byte[]|error {
        if !self.getIsConnected() {
            return error("Not connected to a remote server");
        }

        // Try to read the requested number of bytes from the buffer
        byte[]|io:Error readBytes = self.read(nBytes);
        if readBytes is byte[] && readBytes.length() == nBytes {
            return readBytes;
        }

        // No bytes or not enough bytes available in the buffer, read from the TCP client
        tcp:Client? tcpClient = self.getTcpClient();
        if tcpClient == () {
            return error("No active TCP client to read data from");
        }

        (byte[] & readonly)|tcp:Error clientReadBytes = tcpClient->readBytes();
        if clientReadBytes is tcp:Error {
            return error("Error reading data from the TCP client: " + clientReadBytes.message());
        }

        // Set the read bytes to the buffer and read the requested number of bytes
        self.appendReceivedBytes(clientReadBytes);
        return self.read(nBytes);
    }

    remote function write(byte[] data) returns error? {
        tcp:Client? tcpClient = self.getTcpClient();
        if tcpClient is tcp:Client {
            return check tcpClient->writeBytes(data);
        }
        return error("No active TCP client to write data to");
    }

    remote function close() returns error? {
        tcp:Client? tcpClient = self.getTcpClient();
        if tcpClient is tcp:Client {
            check tcpClient->close();
            self.setIsConnected(false);
        }
        return error("No active TCP client to close");
    }

    public function getIsConnected() returns boolean {
        lock {
            return self.isConnected;
        }
    }

    private function setIsConnected(boolean isConnected) {
        lock {
            self.isConnected = isConnected;
        }
    }

    private function getTcpClient() returns tcp:Client? {
        lock {
            return self.tcpClient;
        }
    }

    private function setTcpClient(tcp:Client? tcpClient) {
        lock {
            self.tcpClient = tcpClient;
        }
    }

    private function read(int nBytes) returns byte[] & readonly|io:Error {
        lock {
            return check self.byteChannel.read(nBytes).cloneReadOnly();
        }
    }

    private function appendReceivedBytes(byte[] newBytes) {
        lock {
            self.receivedBytes = [...self.receivedBytes, ...newBytes];
        }
    }

}
