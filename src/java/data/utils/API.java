/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.utils;

/**
 *
 * @author ASUS
 */
public class API {
    public static String splitName(String fullName){
        String[] a = fullName.split(" ");
        return a[a.length-1];
    }
}
