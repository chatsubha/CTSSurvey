package com.cts.survey.controller;

import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.ow2.bonita.connector.impl.email.SMTPAuthenticator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cts.survey.form.ContactForm;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.mail.util.MailSSLSocketFactory;



@Controller
public class SurveyController {
	
	private static final String COMMA_DELIMITER = ",";
	private static final String NEW_LINE_SEPARATOR = "\n";
	private  String fileName = "Survey_";
	private static final String filePath = "sample.csv";
	
	@Value("${senderEmailID}")
	private  String senderEmailID;
	@Value("${senderEmailPassword}")
	private  String senderEmailPassword;
	@Value("${mailPort}")
	private  String mailPort;
	@Value("${mail.smtp.host}")
	private  String hostName;
	@Value("${mail.body.tm}")
	private  String mailTmBody;
	
	
	@RequestMapping("/")
	public String takeMeToHome() {
		
		return "welcomePage";
	}
	
	@RequestMapping("/startSurvey")
	public String takeMeToSurvey(ContactForm contactForm,HttpSession session) {
		
		session.setAttribute("contactForm", contactForm);
		System.out.println(contactForm.getEmail());
		return "survey";
	}
	
	@RequestMapping("/endSurvey")
	public String endSurvey(HttpSession session,@RequestParam(name="jsonField") String json) throws JsonProcessingException, IOException, GeneralSecurityException, MessagingException {
		
		
		System.out.println(json);
		ContactForm form = (ContactForm)session.getAttribute("contactForm");
		ObjectMapper mapper = new ObjectMapper();
		JsonNode node = mapper.readTree(json);
		Iterator<Entry<String,JsonNode>> it  =  node.fields();
		
		FileWriter fileWriter = null;
		fileName = fileName+form.getName()+"_"+form.getEmpId()+".csv";
		fileWriter = new FileWriter(fileName);
		int sizeHeader = 0;
		Iterator<String> itHeader = node.fieldNames();
		
		
		while (itHeader.hasNext()) {
			fileWriter.append(itHeader.next());
			fileWriter.append(COMMA_DELIMITER);
		}
		
		
		fileWriter.append(NEW_LINE_SEPARATOR);




		while (it.hasNext()) {
			Entry<String,JsonNode> entry = it.next();
			System.out.println("Key" + entry.getKey());
			System.out.println("Value "+entry.getValue());
			fileWriter.append(entry.getValue().toString());
			fileWriter.append(COMMA_DELIMITER);
			
		}
		
		try {
			fileWriter.flush();
			fileWriter.close();
		} catch (IOException e) {
			System.out.println("Error while flushing/closing fileWriter !!!");
			e.printStackTrace();   
		}
		if(form.getRole().equals("TL")) {
			
			if (node.findValue("email")!=null) {
				String emailList = node.findValue("email").toString();
				System.out.println("Invitation mail "+emailList);
				String[] email = emailList.split(";");
				for (String emailId : email) {
					SendMail(emailId.replaceAll("\"",""), "Invitation for Survey ",mailTmBody, true);
				}
					
				String body =  "<html>"
						+ "<head>"
						+ "</head>"
						+ "<body>"
						+"<font color='blue'>"
						+ "Hi,<br/> Please find the survey report which has been submitted by <b>"+form.getName() +"("+form.getEmpId()+")</b>"
						+"</font>"
						+ "</body>"
						+ "</html>";
				SendMail(senderEmailID, "Cognizant Survey",body, true, fileName, fileName);
			}
			
			
		} else {
			
			String body =  "<html>"
					+ "<head>"
					+ "</head>"
					+ "<body>"
					+"<font color='blue'>"
					+ "Hi,<br/> Please find the survey report which has been submitted by <b>"+form.getName() +"("+form.getEmpId()+")</b>"
					+"</font>"
					+ "</body>"
					+ "</html>";
			SendMail(senderEmailID, "Cognizant Survey",body, true, fileName, fileName);
			
		}
		
		
		return "welcomePage";
	}
  
    public  void SendMail(
            String receipientEmailID,
            String subject,
            String body,
            boolean isHtmlBody) throws GeneralSecurityException, MessagingException, UnsupportedEncodingException {

        SMTPAuthenticator auth = new SMTPAuthenticator(senderEmailID, senderEmailPassword);

        MailSSLSocketFactory sf = new MailSSLSocketFactory();
        sf.setTrustAllHosts(true);

        Properties props = new Properties();
        props.put("mail.smtp.host", hostName);    
        
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", mailPort);  

        Session session = Session.getInstance(props, auth);
        session.setDebug(false);

        MimeMessage message = new MimeMessage(session);

        message.setFrom(new InternetAddress(senderEmailID, "Cognizant survey team"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(receipientEmailID));
        message.setRecipient(Message.RecipientType.CC, new InternetAddress(senderEmailID));
        message.setSubject(subject);

        if (isHtmlBody) {
            message.setContent(body, "text/html; charset=utf-8");
        } else {
            message.setText(body);
        }

        System.out.println("Before Sending...");
        Transport.send(message);
        System.out.println("Mail Send.");
    }

	public  void SendMail(
            String receipientEmailID,
            String subject,
            String body,
            boolean isHtmlBody,
            String filePath,
            String fileName) throws GeneralSecurityException, MessagingException, UnsupportedEncodingException {

        SMTPAuthenticator auth = new SMTPAuthenticator(senderEmailID, senderEmailPassword);

        MailSSLSocketFactory sf = new MailSSLSocketFactory();
        sf.setTrustAllHosts(true);

        Properties props = new Properties();
        props.put("mail.smtp.host", hostName);    
           
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", mailPort);  

        Session session = Session.getInstance(props, auth);
        session.setDebug(true);

        MimeMessage message = new MimeMessage(session);

        message.setFrom(new InternetAddress(senderEmailID, "Cognizant survey team"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(receipientEmailID));
        message.setRecipient(Message.RecipientType.CC, new InternetAddress(senderEmailID));
        message.setSubject(subject);

//            MimeBodyPart mbp = new MimeBodyPart();
//            if (isHtmlBody) {
//                mbp.setContent(body, "text/html");
//            }
//
//            message.setText(body);
        // Create the message part 
        BodyPart messageBodyPart = new MimeBodyPart();
        // Fill the message 
        if (isHtmlBody) {
            messageBodyPart.setContent(body, "text/html; charset=utf-8");
        } else {
            messageBodyPart.setText(body);
        }
        // Create a Multipart 
        Multipart multipart = new MimeMultipart();
        // Add part one
        multipart.addBodyPart(messageBodyPart);
        // // Part two is attachment // // Create second body part 
        messageBodyPart = new MimeBodyPart();
        // Get the attachment 
        DataSource source = new FileDataSource(filePath);
        // Set the data handler to the attachment 
        messageBodyPart.setDataHandler(new DataHandler(source));
        // Set the filename
        messageBodyPart.setFileName(fileName);
        // Add part two 
        multipart.addBodyPart(messageBodyPart);
        // Put parts in message
        message.setContent(multipart);

        System.out.println("Before Sending...");
        Transport.send(message);
        System.out.println("Mail Send.");
    }

}
