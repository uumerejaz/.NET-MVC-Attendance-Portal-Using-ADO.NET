# .NET-MVC Attendance Portal Using ADO.NET

### Installation:  
1)Open the SQL Server and Run the Script ( Database, Tables and Stored Procedures )  
2)Download and Open the Project in Visual Studio  
3)Open Web.Config FIle, Go to Connection String and Write Your PC Name in the Server  


### Features:
1)Custom Login and Signup Functionality.  
2)User can mark his current day attendance only and once user marked the checkout time, he can not change it.  
3)User cannot change or alter any previous attendance.  
4)User can also mark his Short Leave in (Hrs) of the current day.  
5)Admin can log in to see attendance details of all the users and download excel file.  
6)Sessions are also handled which prevents directly accessing any URL and don't allow to Go Back after logging Out.  

### Tools and Languages:
1).Net MVC  
2)C#  
3)ADO.NET  
4)SQL  
5)Javascript  
6)Jquery  
7)JSON  
8)AJAX  
9)HTML  
10)CSS  
11)Stored Procedures  
12)Visual Studio  
13)MS SQL Server  

# Details and Screenshots:  

#### If the User Email already exists, system will not allow to Create New account  
![Signup](https://user-images.githubusercontent.com/66524984/205482510-b9ffdba0-ed5c-40ba-9e73-cd3d67049d2d.PNG)

#### If the Email or Password was wrong during login, System will show Alert  
![Signin](https://user-images.githubusercontent.com/66524984/205482520-cfecb46f-f29a-475d-823d-2e00dd0b85d6.PNG)

#### This is the Interface to show User's all previous Attendance with Date, Checkin/Checkout time and Short Leave. User Cannot Alter any previous Attendance once Entered. On the Top Right Corner User's Email will be Shown and  below that is Logout Button. On clicking logout User will be logged out and returned to the Login Screen ( All Session Data will be cleared and If User try to press Back Button, User will not allowed to go back and will be stayed on Login Screen )  
![Attendance](https://user-images.githubusercontent.com/66524984/205482524-c781077e-5c8a-48e9-b6e4-307af314c75b.PNG)

#### After Marking the Checkin Time, Checkout Button and Mark Shortleave Input Field appears  
![ShortLeave](https://user-images.githubusercontent.com/66524984/205482525-a82c024e-b8c1-4e68-ab19-e1b6b5992937.PNG)

#### After Clicking the Checkout Button, User will not be allowed to change the Short Leave Field or change his Checkout time  
![AlreadyMarked](https://user-images.githubusercontent.com/66524984/205482527-b4a559f9-9f68-4596-ab0b-f54df4c2f217.PNG)

#### If we Login with the Admin Email ( Admin can be Created in the Employee Table by Changing the Usertype to 2 ), Same Login Screen will be Used for Admin Login. Admin can see Attendance Details of all the Employee's and Download the Excel File by Clicking on 'Export Data Button'. Some Rows in the Table Showing Empty CheckOut Time which means that User had not marked the Checkout Time  
![Admin](https://user-images.githubusercontent.com/66524984/205482530-962362e4-3e17-434b-9461-b4af6c50f795.PNG)

 # Tables Structure

#### Admin in the Employee Table has UserType '2'. We Can also make anyone an Admin by changing its UserType to '2'. In the Attendance Table Some Rows (12,13,14) has Checkout Time '1900-01-01 00:00:00.000' It means that the User had not Marked his Checkout Time on those Days  
![Table](https://user-images.githubusercontent.com/66524984/205484905-82a20ff8-4528-4675-b5ca-f24c1a8eb045.PNG)



