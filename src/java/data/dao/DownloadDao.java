package data.dao;

import java.util.List;
import model.Download;

public interface DownloadDao {
    List<Download> getAllDownloads();
    boolean createDownload(String platform, String version, String fileUrl, String fileSize);
    boolean updateDownload(int id, String platform, String version, String fileUrl, String fileSize);
    boolean deleteDownload(int id);
}