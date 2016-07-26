package com.wangfj.edi.bean;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import jxl.HeaderFooter;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

public class ExcelField {
	private String Title;
	private List<String> Header;
	private List<List<String>> Data;
	
	private WritableWorkbook workbook;
	private WritableSheet wsheet;
	
	private HeaderFooter pageHeader;
	private HeaderFooter pageFooter;
	private WritableCellFormat headerFormat;
	private WritableFont titleFont;
	private WritableCellFormat titleFormat;
	private WritableFont headerFont;
	
	public WritableFont getTitleFont() {
		return titleFont;
	}

	public void setTitleFont(WritableFont titleFont) {
		this.titleFont = titleFont;
	}

	public WritableCellFormat getTitleFormat() {
		return titleFormat;
	}

	public void setTitleFormat(WritableCellFormat titleFormat) {
		this.titleFormat = titleFormat;
	}

	public WritableFont getHeaderFont() {
		return headerFont;
	}

	public void setHeaderFont(WritableFont headerFont) {
		this.headerFont = headerFont;
	}

	{
		// 设置打印页头
		pageHeader = new HeaderFooter();
		pageHeader.getLeft().appendDate();
		pageHeader.getLeft().append(" ");
		pageHeader.getLeft().appendTime();
		pageHeader.getCentre().appendWorkSheetName();
		pageHeader.getRight().append("");

		// 设置打印页脚
		pageFooter = new HeaderFooter();
		pageFooter.getCentre().appendPageNumber();
		pageFooter.getCentre().append("/");
		pageFooter.getCentre().appendTotalPages();

		// 设置标题
		titleFont = new WritableFont(WritableFont.createFont("黑体"), 23,
				WritableFont.BOLD);
		titleFormat = new WritableCellFormat(titleFont);
		try {
			titleFormat.setAlignment(Alignment.CENTRE);
			titleFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
		} catch (WriteException e) {
			e.printStackTrace();
		}

		// 创建表头样式
		headerFont = new WritableFont(WritableFont.createFont("宋体"), 10,
				WritableFont.BOLD);
		headerFormat = new WritableCellFormat(headerFont);
		try {
			headerFormat.setWrap(true);
		} catch (WriteException e) {
			e.printStackTrace();
		}

	} 
	
	public HeaderFooter getPageHeader() {
		return pageHeader;
	}

	public void setPageHeader(HeaderFooter pageHeader) {
		this.pageHeader = pageHeader;
	}

	public HeaderFooter getPageFooter() {
		return pageFooter;
	}

	public void setPageFooter(HeaderFooter pageFooter) {
		this.pageFooter = pageFooter;
	}

	public WritableCellFormat getHeaderFormat() {
		return headerFormat;
	}

	public void setHeaderFormat(WritableCellFormat headerFormat) {
		this.headerFormat = headerFormat;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public void setHeader(List<String> header) {
		Header = header;
	}

	public void setData(List<List<String>> data) {
		Data = data;
	}

	public WritableWorkbook getWorkbook() {
		return workbook;
	}

	public void setWorkbook(WritableWorkbook workbook) {
		this.workbook = workbook;
	}

	public WritableSheet getWsheet() {
		return wsheet;
	}

	public void setWsheet(WritableSheet wsheet) {
		this.wsheet = wsheet;
	}

	public ExcelField() {
	};

	public ExcelField(String title, List<String> header, List<List<String>> data) {
		super();
		Title = title;
		Header = header;
		Data = data;
	}
	
	public boolean save(OutputStream fileName) throws IOException {
		// 创建WorkBook 和 Sheet
		workbook = Workbook.createWorkbook(fileName);
		wsheet = workbook.createSheet(this.Title, workbook.getNumberOfSheets());
		// 设置工作表全局设定
		SheetSettings sheetSettings = wsheet.getSettings();
		sheetSettings.setHeader(this.pageHeader);
		sheetSettings.setFooter(this.pageFooter);
		// sheetSettings.setDefaultRowHeight(500);
		sheetSettings.setFitToPages(true);
		sheetSettings.setPrintHeaders(false);
		sheetSettings.setDisplayZeroValues(true);
		sheetSettings.setPrintGridLines(true);
		sheetSettings.setFitWidth(1);
		sheetSettings.setDefaultColumnWidth(20);
		try {
			// 标题文字
//			Label nc1 = new Label(0, 0, this.Title, titleFormat);
			// 合并单元格
//			wsheet.mergeCells(0, 0, this.Header.size() - 1, 0);

			// 插入标题单元格
//			wsheet.addCell(nc1);
			// 写入表头
			for (int i = 0; i < this.Header.size(); ++i) {
				Label nc = new Label(i, 0, this.Header.get(i), headerFormat);
				wsheet.addCell(nc);
			}
			// 加入数据
			for (int i = 0; i < this.Data.size(); ++i) {
				for (int j = 0; j < this.Data.get(i).size(); ++j) {
					Label nc = new Label(j, i + 1, this.Data.get(i).get(j));
					wsheet.addCell(nc);
				}
			}
			workbook.write();
			workbook.close();
		} catch (RowsExceededException e) {
			e.printStackTrace();
			return false;
		} catch (WriteException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return Title;
	}

	/**
	 * @return the header
	 */
	public List<String> getHeader() {
		return Header;
	}

	/**
	 * @return the data
	 */
	public List<List<String>> getData() {
		return Data;
	}
}
