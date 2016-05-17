package com.wangfj.statement.entity;

import java.io.OutputStream;
import java.util.List;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class PDFReport {
Document document = new Document();// 建立一个Document对象	
	
	private static Font headfont ;// 设置字体大小
	private static Font keyfont;// 设置字体大小
	private static Font textfont;// 设置字体大小
	

	
	static{
		BaseFont bfChinese;
		try {
			//bfChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
			bfChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
			headfont = new Font(bfChinese, 10, Font.BOLD);// 设置字体大小
			keyfont = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小
			textfont = new Font(bfChinese, 8, Font.NORMAL);// 设置字体大小
		} catch (Exception e) {			
			e.printStackTrace();
		} 
	}
	
	
	public  PDFReport(OutputStream file) {		 
		 document.setPageSize(PageSize.A4);// 设置页面大小
		 try {
			PdfWriter.getInstance(document,file);
			document.open(); 
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		
	}
	int maxWidth = 520;
	
	
	 public PdfPCell createCell(String value,com.lowagie.text.Font font,int align){
		 PdfPCell cell = new PdfPCell();
		 cell.setVerticalAlignment(Element.ALIGN_MIDDLE);		 
		 cell.setHorizontalAlignment(align);	
		 cell.setPhrase(new Phrase(value,font));
		return cell;
	}
	
	 public PdfPCell createCell(String value,com.lowagie.text.Font font){
		 PdfPCell cell = new PdfPCell();
		 cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		 cell.setHorizontalAlignment(Element.ALIGN_CENTER);	
		 cell.setPhrase(new Phrase(value,font));
		return cell;
	}

	 public PdfPCell createCell(String value,com.lowagie.text.Font font,int align,int colspan){
		 PdfPCell cell = new PdfPCell();
		 cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		 cell.setHorizontalAlignment(align);	
		 cell.setColspan(colspan);
		 cell.setPhrase(new Phrase(value,font));
		return cell;
	}
	public PdfPCell createCell(String value,com.lowagie.text.Font font,int align,int colspan,boolean boderFlag){
		 PdfPCell cell = new PdfPCell();
		 cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		 cell.setHorizontalAlignment(align);	
		 cell.setColspan(colspan);
		 cell.setPhrase(new Phrase(value,font));
		 cell.setPadding(3.0f);
		 if(!boderFlag){
			 cell.setBorder(0);
			 cell.setPaddingTop(15.0f);
			 cell.setPaddingBottom(8.0f);
		 }
		return cell;
	}
	 public PdfPTable createTable(int colNumber){
		PdfPTable table = new PdfPTable(colNumber);
		try{
			table.setTotalWidth(maxWidth);
			table.setLockedWidth(true);
			table.setHorizontalAlignment(Element.ALIGN_CENTER);		
			table.getDefaultCell().setBorder(1);
		}catch(Exception e){
			e.printStackTrace();
		}
        return table;
	}
	 public PdfPTable createTable(float[] widths){
			PdfPTable table = new PdfPTable(widths);
			try{
				table.setTotalWidth(maxWidth);
				table.setLockedWidth(true);
				table.setHorizontalAlignment(Element.ALIGN_CENTER);		
				table.getDefaultCell().setBorder(1);
			}catch(Exception e){
				e.printStackTrace();
			}
	        return table;
		}
	
	 public PdfPTable createBlankTable(){
		 PdfPTable table = new PdfPTable(1);
		 table.getDefaultCell().setBorder(0);
		 table.addCell(createCell("", keyfont));		 
		 table.setSpacingAfter(20.0f);
		 table.setSpacingBefore(20.0f);
		 return table;
	 }
	 public void generatePDF(List<String> head, List<List<String>> data,int rows,String title) throws Exception{
			PdfPTable table = createTable(rows);
			table.addCell(createCell(title, keyfont,Element.ALIGN_LEFT,rows,false));
			for(String str:head){
				table.addCell(createCell(str, keyfont, Element.ALIGN_CENTER));
			}
			for(List<String> list:data){
				for(String str:list){
					table.addCell(createCell(str, textfont));
				}
			}
			/*for(int i=0;i<5;i++){
				table.addCell(createCell("姓名"+i, textfont));
				table.addCell(createCell(i+15+"", textfont));
				table.addCell(createCell((i%2==0)?"男":"女", textfont));
				table.addCell(createCell("地址"+i, textfont));
			}*/
			document.add(table);
			
			document.close();
		 }
}
