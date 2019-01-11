package com.love.home.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.love.model.Album;
import com.love.model.User;
import com.love.util.DateUtil;
import com.love.util.Utils;

/**
 * Servlet implementation class upload
 */
@WebServlet(
		description = "头像上传及照片上传处理", 
		urlPatterns = { "/home/main/upload" }
)
public class upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "upload";
 
    // 上传配置
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public upload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append(getServletContext().getRealPath("/"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");    //设置响应字符集
        PrintWriter writer = response.getWriter();
        // 检测是否为多媒体上传
        // 如果不是则停止
        if (!ServletFileUpload.isMultipartContent(request)) {
            writer.write("上传失败");
            return;
        }
 
        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        
        ServletFileUpload upload = new ServletFileUpload(factory);
         
        // 设置最大文件上传值
        upload.setFileSizeMax(MAX_FILE_SIZE);
        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);
        // 中文处理
        upload.setHeaderEncoding("UTF-8"); 
        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        String savePath = UPLOAD_DIRECTORY + File.separator + DateUtil.timeStamp2Date(null, null);
        String uploadPath = this.getServletContext().getRealPath("/") + savePath;
        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        FileItem fileItem = null;
        try {
            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(request);
            if (null != formItems && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                    	fileItem = item;    //获取上传的文件
                    	break;
                    }
                }
            }
        } catch (Exception ex) {
        	writer.write("上传失败");
        }
        if (null != fileItem) {
        	String fileName = fileItem.getName();
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String saveName = String.valueOf(System.currentTimeMillis()) + ext;
            String filePath = uploadPath + File.separator + saveName;
            filePath = filePath.replaceAll("\\\\", "/");
            File storeFile = new File(filePath);
            // 在控制台输出文件的上传路径
            // 保存文件到硬盘
            try {
				fileItem.write(storeFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				storeFile.delete();
				writer.write("上传失败");
				return;
			}
            savePath = (request.getContextPath() + File.separator + savePath + File.separator + saveName).replaceAll("\\\\", "/");
            String id = (String) request.getAttribute("id");
        	if (fileItem.getFieldName().equals("album")) {
        		Album album = new Album();
        		boolean result = album.upload(id, savePath);
        		album.close();
        		if (!result) {
        			storeFile.delete();
        			writer.write("上传失败");
        			return;
        		}
        	} else {
        		User user = new User();
        		int result = user.uploadAvatar(id, savePath);
        		user.close();
        		if (0 == result) {
        			storeFile.delete();
        			writer.write("上传失败");
        			return;
        		}
        	}
        }
        response.sendRedirect("album.jsp");
	}

}
