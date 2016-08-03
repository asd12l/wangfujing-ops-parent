package com.wangfj.back.util;

import java.awt.AlphaComposite;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Transparency;
import java.awt.geom.GeneralPath;
import java.awt.geom.Line2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import jxl.format.RGB;

public class CaptchaUtil {
	
	public void getBigPic(String url, OutputStream out){
		String name = url.substring(url.lastIndexOf("/")+1, url.lastIndexOf("."));
		String[] strs = name.split("_");
		String path = url.substring(0, url.lastIndexOf("/")+1) + strs[0] + ".png";
		int startX = Integer.valueOf(strs[1]);
		int startY = Integer.valueOf(strs[2]);
		int width = 50, height = 50;
		float transparency = 0.7f;
		AlphaComposite newComposite = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, transparency);
		try {
			BufferedImage img1 = ImageIO.read(new File(path));
			int w = img1.getWidth();
			int h = img1.getHeight();
			Image image=img1.getScaledInstance(w, h, BufferedImage.SCALE_SMOOTH);
			
			BufferedImage resultImg=new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
			Graphics2D g2d = resultImg.createGraphics(); 
			g2d.drawImage(image, 0, 0, w, h, null);
			g2d.dispose(); 
			
			g2d = resultImg.createGraphics(); 
			g2d.setPaint(Color.WHITE); 
			g2d.setComposite(newComposite);
			g2d.fill3DRect(startX, startY, width, height, false);
			g2d.dispose();
			
			ImageIO.write(resultImg, "png", out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getLittlePic(String url, OutputStream out){
		String name = url.substring(url.lastIndexOf("\\")+1, url.lastIndexOf("."));
		String[] strs = name.split("_");
		String path = url.substring(0, url.lastIndexOf("\\")+1) + strs[0] + ".png";
		int startX = Integer.valueOf(strs[1]);
		int startY = Integer.valueOf(strs[2]);
		int width = 50, height = 50;
		try {
			BufferedImage img1 = ImageIO.read(new File(path));
			int w = img1.getWidth();
			int h = img1.getHeight();
			Image image=img1.getScaledInstance(w, h, BufferedImage.SCALE_SMOOTH);
			
			BufferedImage resultImg=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			
			Graphics2D g2d = resultImg.createGraphics(); 
			g2d.drawImage(image, -startX, -startY, w, h, null);
			g2d.dispose(); 
			
			ImageIO.write(resultImg, "png", out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getLittlePic1(String url, OutputStream out){
		String name = url.substring(url.lastIndexOf("/")+1, url.lastIndexOf("."));
		String[] strs = name.split("_");
		String path = url.substring(0, url.lastIndexOf("/")+1) + strs[0] + ".jpg";
		int startX = Integer.valueOf(strs[1]);
		int startY = Integer.valueOf(strs[2]);
		int width = 50, height = 50;
		try {
			BufferedImage img1 = ImageIO.read(new File(path));
			int w = img1.getWidth();
			int h = img1.getHeight();
			Image image=img1.getScaledInstance(w, h, BufferedImage.SCALE_SMOOTH);
			
			BufferedImage resultImg=new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
			
			Graphics2D g2d = resultImg.createGraphics(); 
			g2d.drawImage(image, 0, 0, w, h, null);
			g2d.dispose(); 
			
			BufferedImage litpic=new BufferedImage(50, 50, BufferedImage.TYPE_INT_RGB);
			
			Graphics2D g2d1 = litpic.createGraphics();  
			litpic = g2d1.getDeviceConfiguration().createCompatibleImage(60, 50, Transparency.TRANSLUCENT);  
			g2d1.dispose(); 
			
			g2d1 = litpic.createGraphics();
			g2d1.setColor(new Color(255,0,0));
			g2d1.setStroke(new BasicStroke(1));
			g2d1.dispose();
			
			
			g2d1 = litpic.createGraphics(); 
			g2d1.setPaint(Color.gray);
			g2d1.fillRect(8, 16, 35, 13);
			g2d1.fillRect(11, 10, 13, 25);
			g2d1.fillRect(28, 10, 13, 25);
			g2d1.fillOval(3, 16, 13, 13);
			g2d1.fillOval(38, 15, 13, 13);
			g2d1.fillOval(10, 5, 13, 13);
			g2d1.fillOval(27, 5, 13, 13);
			g2d1.fillOval(10, 27, 13, 13);
			g2d1.fillOval(28, 27, 13, 13);
			g2d1.dispose();
			
			
			g2d = resultImg.createGraphics(); 
			g2d.drawImage(litpic, 30, 30, 60, 50, null);
			g2d.dispose(); 
			
			
			ImageIO.write(resultImg, "png", out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws IOException {
		File file = new File("E:/10.png");
		CaptchaUtil util = new CaptchaUtil();
		FileOutputStream out = new FileOutputStream(file);
		util.getBigPic("E:/2_10_30.jpg", out);
		out.close();
	}
}
