import java.io.*;
import java.math.BigInteger;
import java.nio.file.*;
import java.nio.charset.*;
import java.security.*;
import java.util.List;

class Useradmin {
	
	public static void main(String[] args) {
		if (args.length == 2) {
			String method = args[0];
			String username = args[1];
			Console console = System.console();
			System.out.println("Enter the password:");
			String password = console.readLine();
			Useradmin useradmin = new Useradmin();
			switch (method) {
				case "addUser":
					useradmin.addUser(username, password.toCharArray());
					break;
				case "checkUser":
					boolean result = useradmin.checkUser(username, password.toCharArray());
					System.out.println("Does the user " + username + " exist? " + result);
					break;
			}
		}
		else {
			System.out.println("Please provide 2 parameters: addUser|checkUser <username>");
		}
	}

	public void addUser(String username, char[] password) {
		String salt = genSalt();
		String hashedPW = generateHash(String.valueOf(password), salt);
		String format = username + ":" + hashedPW;
		try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("passwords.txt", true)))) {
		    out.println(format);
		    System.out.println("User has been created");
		} catch (IOException e) {
		    //exception handling left as an exercise for the reader
		}
	}

	public boolean checkUser(String username, char[] password) {
		boolean result = false;
		try {
			List<String> passwords = Files.readAllLines(Paths.get("passwords.txt"), StandardCharsets.UTF_8);

			for (String uidPW : passwords) {
				int indexOfColon = uidPW.indexOf(':');
				String user = uidPW.substring(0, indexOfColon);
				String pwSalt = uidPW.substring(indexOfColon + 1);
				indexOfColon = pwSalt.indexOf(':');
				String salt = pwSalt.substring(0, indexOfColon);
				String hashedPWString = generateHash(String.valueOf(password), salt);

				if (user.equals(username) && pwSalt.equals(hashedPWString)) {
					result = true;
				}
			}
		}
		catch (IOException ioe) {

		}
		return result;
	}

	private String generateHash(String str, String salt) {
	  	String hashValue = salt + str;
		for (int i = 0; i < 4200; i++) {
			 hashValue = hash(hashValue); 
		}
		return salt + ":" + hashValue;
	}

	private String hash(String str) {
	 try {
		byte[] plain = str.getBytes(StandardCharsets.UTF_8);
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(plain);
		return new BigInteger(1, md.digest()).toString(16);
      } catch (NoSuchAlgorithmException e) {
		  throw new UnsupportedOperationException(e);
	  }

	}

	private String genSalt() {
    	SecureRandom random = new SecureRandom();
    	return new BigInteger(32, random).toString(32);
	}
}
