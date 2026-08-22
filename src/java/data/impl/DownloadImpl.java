package data.impl;

import data.driver.MySQLDriver;
import data.dao.DownloadDao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Download;

public class DownloadImpl implements DownloadDao {

    @Override
    public List<Download> getAllDownloads() {
        List<Download> list = new ArrayList<>();
        String sql = "SELECT * FROM downloads ORDER BY id ASC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Download d = new Download();
                d.setId(rs.getInt("id"));
                d.setPlatform(rs.getString("platform"));
                d.setVersion(rs.getString("version"));
                d.setFileUrl(rs.getString("file_url"));
                d.setFileSize(rs.getString("file_size"));
                d.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean createDownload(String platform, String version, String fileUrl, String fileSize) {
        String sql = "INSERT INTO downloads (platform, version, file_url, file_size, created_at) VALUES (?, ?, ?, ?, NOW())";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, platform);
            ps.setString(2, version);
            ps.setString(3, fileUrl);
            ps.setString(4, fileSize);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateDownload(int id, String platform, String version, String fileUrl, String fileSize) {
        String sql = "UPDATE downloads SET platform = ?, version = ?, file_url = ?, file_size = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, platform);
            ps.setString(2, version);
            ps.setString(3, fileUrl);
            ps.setString(4, fileSize);
            ps.setInt(5, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteDownload(int id) {
        String sql = "DELETE FROM downloads WHERE id = ?";
        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}