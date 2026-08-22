package model;

import java.sql.Timestamp;

public class Download {
    private int id;
    private String platform;   // PC (Windows), Android (APK), IOS...
    private String version;    // v1.2.0
    private String fileUrl;    // Link tải
    private String fileSize;   // 125 MB
    private Timestamp createdAt;

    public Download() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPlatform() { return platform; }
    public void setPlatform(String platform) { this.platform = platform; }

    public String getVersion() { return version; }
    public void setVersion(String version) { this.version = version; }

    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public String getFileSize() { return fileSize; }
    public void setFileSize(String fileSize) { this.fileSize = fileSize; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}