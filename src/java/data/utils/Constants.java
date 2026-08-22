package data.utils;

public class Constants {

    public static final String DB_HOST =
            System.getenv().getOrDefault("DB_HOST", "localhost");

    public static final String DB_PORT =
            System.getenv().getOrDefault("DB_PORT", "3306");

    public static final String DB_NAME =
            System.getenv().getOrDefault("DB_NAME", "chien_binh_online");

    public static final String USER =
            System.getenv().getOrDefault("DB_USER", "root");

    public static final String PASS =
            System.getenv().getOrDefault("DB_PASSWORD", "");

    public static final String DB_URL =
            "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME
            + "?useUnicode=true"
            + "&characterEncoding=UTF-8"
            + "&serverTimezone=Asia/Ho_Chi_Minh";
}