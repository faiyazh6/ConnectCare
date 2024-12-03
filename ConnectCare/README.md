# ConnectCare

**ConnectCare** is a Swift-based iOS application designed to streamline task and care management between **Primary Caregivers** and **Family Members**. The app provides features like task and reminder management, calendar integration, and role-based permissions, ensuring effective collaboration and seamless communication in caregiving scenarios.

---

## Features

### 1. Role-Based Access Control
- **Primary Caregiver**:
  - Add, edit, and delete tasks and reminders.
  - Full control over care notes, including adding and deleting notes.
- **Family Member**:
  - View tasks, reminders, and care notes.
  - Cannot delete or modify entries created by the caregiver.
  - Cannot add new care notes.

### 2. Task Manager
- Add, view, and manage tasks.
- Mark tasks as completed with a **strikethrough** and smooth disappearing animation.
- Drag and drop tasks to reorder them.
- Tasks are filtered based on the current user's role to ensure access permissions.

### 3. Reminder Management
- Add reminders with specific times.
- Integrated with **Apple's Notification Center** to send alerts for reminders.
- Reminders created by one role cannot be deleted by the other.

### 4. Care Notes
- A collaborative space for managing care-related notes.
- **Family Members** can view notes but are restricted from adding or deleting them.

### 5. Calendar Integration
- View tasks organized by date in a user-friendly calendar.
- Navigate between months to see tasks for specific days.
- Displays "No tasks for this date" when no tasks exist for a selected day.

### 6. Gesture Recognition
- Drag and drop support for reordering tasks and reminders.

### 7. Persistent Data Storage
- Uses `@AppStorage` to save tasks, reminders, and user roles persistently across app launches.

---

## Getting Started

### Prerequisites
- Xcode 14.0 or later.
- iOS 15.0 or later for the target device or simulator.

### Installation
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/ConnectCare.git
2. Open the project by navigating to the project directory and double-clicking the `ConnectCare.xcodeproj` file:
   ```bash
   open ConnectCare.xcodeproj
3. To run the app, select the desired target device or simulator from the toolbar, and press the Run button or use the shortcut
    or use the shortcut Command + R

## Usage

### Initial Setup
1. Upon launching the app, you will be prompted to **Select Your Role**:
   - **Primary Caregiver**
   - **Family Member**
2. Enter the role-specific password when prompted:
   - Primary Caregiver: `primarycaregiver`
   - Family Member: `familymember`
3. If the password is incorrect, a **Password Failed** message will appear, allowing you to try again.
4. Successful login will take you to the **Home View**.

---

## App Features

### Task Management
- **Add Tasks**: Click the **Add New Task** button, provide a title, and select a due date.
- **Task List**: Tasks are displayed in an organized list.
- **Mark as Completed**: Tap the checkmark button next to a task to mark it as completed.
- **Reorder Tasks**: Use drag-and-drop gestures to reorder tasks in the list.
- **Delete Tasks**: Swipe to delete tasks. Deleted tasks will disappear with a smooth animation.
- **Role-Specific Permissions**:
  - Caregivers cannot delete tasks created by Family Members and vice versa.

### Reminder Management
- **Add Reminders**: Provide a title and set a specific time for the reminder.
- **Push Notifications**: Receive timely notifications for scheduled reminders.
- **Role-Based Deletion**: Reminders can only be deleted by the user role that created them.
- **Reorder Reminders**: Drag and drop reminders to reorder them.

### Care Notes
- **View Care Notes**: Both Primary Caregivers and Family Members can view care notes.
- **Restricted Actions for Family Members**:
  - Family Members can only view care notes and cannot add or delete them.
  - A **restricted access message** is displayed for Family Members.

### Calendar Integration
- **Date-Based Task Display**: Tasks are displayed based on their due date.
- **Monthly Navigation**: Navigate through months using arrow buttons.
- **Selected Date View**:
  - Tasks for the selected date are displayed in a clean, scrollable list.
  - If no tasks exist for the selected date, a **"No tasks for this date"** message is shown.

---

## Architecture Overview

### Views
- **RoleSelectionView**: Manages role selection and password authentication.
- **TaskManagerView**: Handles task-related features such as adding, completing, deleting, and reordering tasks.
- **ReminderView**: Manages reminders, including notifications and reordering.
- **CareNotesView**: Displays care notes with restricted actions based on user roles.
- **CalendarView**: Displays a calendar interface for browsing tasks by date.

### Models
- **Task**:
  - `title`: String - Title of the task.
  - `isCompleted`: Bool - Marks the task as completed or not.
  - `isDeleted`: Bool - Tracks whether the task has been marked for deletion.
  - `dueDate`: Date - Due date of the task.
  - `role`: String - Role of the creator (Primary Caregiver or Family Member).
- **Reminder**:
  - `title`: String - Title of the reminder.
  - `time`: Date - Time for the reminder.
  - `role`: String - Role of the creator (Primary Caregiver or Family Member).

---

## Notes
- **Persistent Data Storage**: Tasks, reminders, and care notes are saved persistently using `@AppStorage`.
- **Gesture Recognition**:
  - Drag-and-drop gestures for reordering tasks and reminders.
  - Swipe gestures for deleting tasks or reminders (role-permitted).
- **Role-Based Permissions**: Ensures appropriate access control between Primary Caregivers and Family Members.
- **User-Friendly Animations**: Smooth transitions for adding, deleting, and completing tasks.

---

## Features

### Key Functionalities
1. **Role-Based User Authentication**:
   - Users can log in as either a Primary Caregiver or Family Member with role-based restrictions and features.
   - Caregivers can add, edit, and delete tasks and reminders, whereas family members have limited permissions.

2. **Task Management**:
   - Users can create tasks with titles, due dates, and completion status.
   - Drag-and-drop gesture support allows reordering of tasks.
   - Role-based permissions ensure only the creator of a task can edit or delete it.

3. **Reminders**:
   - Reminders can be created with specific times and titles.
   - Swipe gestures enable quick actions such as deleting (restricted to the creator's role).

4. **Calendar Integration**:
   - Users can view tasks by date using an interactive calendar.
   - If no tasks are present for a date, the app displays a "No tasks for this date" message in a polished format.

5. **HealthKit Integration**:
   - The app tracks step count data and displays it in the user interface.
   - Health data is securely accessed with the required privacy strings.

6. **Gesture Recognition**:
   - Supports swipe-to-delete for reminders and drag-and-drop gestures for task reordering.

7. **Persistent Data Storage**:
   - Tasks and reminders are stored locally using `AppStorage`, ensuring they persist between app launches.

---

## Implementation of Course Concepts

### Gesture Recognition
- **Swipe-to-Delete**:
  - Swipe gestures are used to delete tasks and reminders. Role-based permissions are enforced to ensure only the creator can delete their content.
- **Drag-and-Drop Support**:
  - Tasks can be reordered using drag-and-drop gestures in the task list.

### Persistent Data Storage
- The app uses `AppStorage` to store tasks and reminders persistently, ensuring data is saved and accessible even after the app is closed.

### HealthKit Integration
- The app integrates with HealthKit to track and display step count data in a user-friendly manner. This includes secure handling of user permissions and privacy strings for HealthKit access.

### Additional Features
- **Interactive Calendar**:
  - Tasks are displayed by date in an interactive calendar view.
  - Displays "No tasks for this date" if no tasks are found for the selected date.
- **Password-Based Login**:
  - Login screens validate user roles with predefined passwords and display error messages for failed attempts.

---

## How It Meets the Rubric
1. **App Lifecycle, Structure, and MVVM**:
   - The app follows a clear MVVM architecture with views, models, and app-level storage, ensuring maintainability and scalability.
2. **Gesture Recognition**:
   - Drag-and-drop for task reordering and swipe-to-delete functionality fulfill this course requirement.
3. **Persistent Data Storage**:
   - Tasks and reminders are stored using `AppStorage`, ensuring data persists across sessions.
5. **User Experience Design**:
   - The app's interface is designed with clarity and accessibility in mind, featuring polished layouts, error messages, and role-specific views.

---

