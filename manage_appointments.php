<?php
include 'header.php';
include 'dbconnect.php';
<<<<<<< HEAD
=======
require 'vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use Dotenv\Dotenv;

// Load environment variables
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Function to send cancellation email for appointments
function sendCancellationEmail($email, $appointmentDetails) {
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host = $_ENV['SMTP_HOST'];
        $mail->SMTPAuth = true;
        $mail->Username = $_ENV['SMTP_USER'];
        $mail->Password = $_ENV['SMTP_PASSWORD'];
        $mail->SMTPSecure = 'ssl';
        $mail->Port = $_ENV['SMTP_PORT'];

        $mail->setFrom($_ENV['SMTP_USER'], 'Glamour Salon');
        $mail->addAddress($email);

        $mail->isHTML(true);
        $mail->Subject = 'Glamour Salon: Appointment Cancellation Confirmation';
        $mail->Body = $appointmentDetails;

        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5

// Start session and check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    echo "<script type='text/javascript'>
        window.location.href = 'login.php';
<<<<<<< HEAD
    </script>";
=======
        </script>";
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    exit;
}

$user_id = $_SESSION['user_id'];
<<<<<<< HEAD
$message = '';

// Handle cancel appointment action
if (isset($_GET['cancel_appointment'])) {
    $appointment_id = (int) $_GET['cancel_appointment'];

    // Fetch appointment details before deleting
    $stmt_appointment = $pdo->prepare("
        SELECT a.appointment_id, a.appointment_date, a.appointment_time, a.status, s.name AS service_name, 
               CONCAT(u_staff.first_name, ' ', u_staff.last_name) AS staff_name
        FROM appointments a
        JOIN services s ON a.service_id = s.service_id
        LEFT JOIN users u_staff ON a.staff_id = u_staff.user_id AND u_staff.role = 'staff'
        WHERE a.appointment_id = :appointment_id AND a.user_id = :user_id
        LIMIT 1
=======

// Handle cancel appointment action
if (isset($_GET['cancel_appointment'])) {
    $appointment_id = $_GET['cancel_appointment'];

    // Fetch appointment details before deleting for the email
    $stmt_appointment = $pdo->prepare("
        SELECT a.appointment_id, a.appointment_date, a.appointment_time, s.name AS service_name, 
               CONCAT(u_staff.first_name, ' ', u_staff.last_name) AS staff_name, u.email, u.first_name, u.last_name
        FROM appointments a
        JOIN services s ON a.service_id = s.service_id
        LEFT JOIN users u_staff ON a.staff_id = u_staff.user_id AND u_staff.role = 'staff'
        JOIN users u ON a.user_id = u.user_id
        WHERE a.appointment_id = :appointment_id AND a.user_id = :user_id
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    ");
    $stmt_appointment->execute([
        'appointment_id' => $appointment_id,
        'user_id' => $user_id
    ]);

    $appointment = $stmt_appointment->fetch(PDO::FETCH_ASSOC);

<<<<<<< HEAD
    if ($appointment) {
        $stmt = $pdo->prepare("
            DELETE FROM appointments
            WHERE appointment_id = :appointment_id AND user_id = :user_id
        ");
        $stmt->execute([
            'appointment_id' => $appointment_id,
            'user_id' => $user_id
        ]);

        $message = 'Appointment successfully canceled.';
    } else {
        $message = 'Appointment not found.';
    }
}

// Fetch user's appointments from the database
=======
    // Delete the appointment from the database
    $stmt = $pdo->prepare("DELETE FROM appointments WHERE appointment_id = :appointment_id AND user_id = :user_id");
    $stmt->execute([
        'appointment_id' => $appointment_id,
        'user_id' => $user_id
    ]);

    $message = 'Appointment successfully canceled.';

    // Prepare the cancellation email content
    $appointmentDetails = "<h2>Appointment Cancellation</h2>";
    $appointmentDetails .= "<p>Dear {$appointment['first_name']} {$appointment['last_name']},</p>";
    $appointmentDetails .= "<p>Your appointment for the service <strong>{$appointment['service_name']}</strong> with staff <strong>{$appointment['staff_name']}</strong> at Glamour Salon has been canceled.</p>";
    $appointmentDetails .= "<p>Date: " . date('F d, Y', strtotime($appointment['appointment_date'])) . "<br>Time: " . date('h:i A', strtotime($appointment['appointment_time'])) . "</p>";
    
    // Send cancellation email
    sendCancellationEmail($appointment['email'], $appointmentDetails);
}

// Fetch user's appointments from the database, including staff information and status
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
$stmt = $pdo->prepare("
    SELECT a.appointment_id, a.appointment_date, a.appointment_time, a.status, s.name AS service_name, 
           CONCAT(u_staff.first_name, ' ', u_staff.last_name) AS staff_name
    FROM appointments a
    JOIN services s ON a.service_id = s.service_id
    LEFT JOIN users u_staff ON a.staff_id = u_staff.user_id AND u_staff.role = 'staff'
    WHERE a.user_id = :user_id
    ORDER BY a.appointment_date DESC, a.appointment_time DESC
");
$stmt->execute(['user_id' => $user_id]);
$appointments = $stmt->fetchAll(PDO::FETCH_ASSOC);
<<<<<<< HEAD
?>

<style>
    .appointments-table-wrapper {
        width: 100%;
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    .appointments-table-main {
        width: 100%;
        min-width: 850px;
        margin-bottom: 0;
    }

    .appointments-table-main th,
    .appointments-table-main td {
        vertical-align: middle;
        white-space: nowrap;
    }

    .appointment-action-buttons {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: center;
    }

    .appointment-action-buttons a {
        text-decoration: none;
    }

    .appointment-action-buttons .ce5 {
        margin: 0;
    }

    @media (max-width: 768px) {
        .appointments-table-main {
            min-width: 0;
        }

        .appointments-table-main thead {
            display: none;
        }

        .appointments-table-main,
        .appointments-table-main tbody,
        .appointments-table-main tr,
        .appointments-table-main td {
            display: block;
            width: 100%;
        }

        .appointments-table-main tr {
            margin-bottom: 15px;
            border: 1px solid #e5e5e5;
            border-radius: 10px;
            background: #fff;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        }

        .appointments-table-main td {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 15px;
            border: none;
            border-bottom: 1px solid #f0f0f0;
            white-space: normal;
            text-align: right;
            font-size: 14px;
        }

        .appointments-table-main td:last-child {
            border-bottom: none;
            align-items: flex-start;
        }

        .appointments-table-main td::before {
            content: attr(data-label);
            font-weight: 600;
            color: #333;
            text-align: left;
            padding-right: 15px;
            flex: 1;
        }

        .appointments-table-main td>* {
            flex: 1;
            text-align: right;
        }

        .appointment-action-buttons {
            justify-content: flex-end;
            width: 100%;
        }

        .appointment-action-buttons a,
        .appointment-action-buttons button {
            width: 100%;
        }

        .appointment-action-buttons .ce5 {
            width: 100%;
            display: block;
        }
    }
</style>

=======

?>

>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
<section class="breadcrumbs-area ptb-100 bg-gray">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <div class="breadcrumbs">
                    <h2 class="page-title">Manage Appointments</h2>
                    <ul>
                        <li>
                            <a class="active" href="index.php">Home</a>
                        </li>
                        <li>Manage Appointments</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="manage-appointments-area pt-90 pb-50">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-xs-12">
                <div class="appointments-table">
<<<<<<< HEAD
                    <?php if (!empty($message)): ?>
                        <div class="alert alert-success"><?= htmlspecialchars($message) ?></div>
                    <?php endif; ?>

                    <?php if (!empty($appointments)): ?>
                        <div class="table-responsive appointments-table-wrapper">
                            <table class="table table-striped appointments-table-main">
                                <thead>
                                    <tr>
                                        <th>Service</th>
                                        <th>Staff</th>
                                        <th>Appointment Date</th>
                                        <th>Appointment Time</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($appointments as $appointment): ?>
                                        <tr>
                                            <td data-label="Service"><?= htmlspecialchars($appointment['service_name']) ?></td>
                                            <td data-label="Staff"><?= htmlspecialchars($appointment['staff_name'] ?? 'N/A') ?></td>
                                            <td data-label="Appointment Date"><?= date('F d, Y', strtotime($appointment['appointment_date'])) ?></td>
                                            <td data-label="Appointment Time"><?= date('h:i A', strtotime($appointment['appointment_time'])) ?></td>
                                            <td data-label="Status"><?= htmlspecialchars(ucfirst($appointment['status'])) ?></td>
                                            <td data-label="Actions">
                                                <div class="appointment-action-buttons">
                                                    <?php
                                                    $appointment_datetime = strtotime($appointment['appointment_date'] . ' ' . $appointment['appointment_time']);
                                                    $current_datetime = time();

                                                    if ($current_datetime < ($appointment_datetime - 86400)): ?>
                                                        <a href="?cancel_appointment=<?= $appointment['appointment_id'] ?>"
                                                            onclick="return confirm('Are you sure you want to cancel this appointment?')">
                                                            <button class="btn btn-primary ce5 mb-1">Cancel Appointment</button>
                                                        </a>
                                                    <?php else: ?>
                                                        <button class="btn btn-primary ce5 mb-1" disabled>Cancel Unavailable</button>
                                                    <?php endif; ?>
                                                </div>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    <?php else: ?>
                        <p style="text-align: center; font-size: 16px; color: #555; padding: 20px;">
                            You have no upcoming appointments.
                        </p>
=======
                    <?php if (isset($message)): ?>
                        <div class="alert alert-success"><?= $message ?></div>
                    <?php endif; ?>

                    <?php if (!empty($appointments)): ?>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Service</th>
                                    <th>Staff</th>
                                    <th>Appointment Date</th>
                                    <th>Appointment Time</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($appointments as $appointment): ?>
                                    <tr>
                                        <td><?= $appointment['service_name'] ?></td>
                                        <td><?= $appointment['staff_name'] ?? 'N/A' ?></td>
                                        <td><?= date('F d, Y', strtotime($appointment['appointment_date'])) ?></td>
                                        <td><?= date('h:i A', strtotime($appointment['appointment_time'])) ?></td>
                                        <td><?= ucfirst($appointment['status']) ?></td>
                                        <td>
                                            <?php 
                                                $appointment_datetime = strtotime($appointment['appointment_date'] . ' ' . $appointment['appointment_time']);
                                                $current_datetime = time();
                                                
                                                if ($current_datetime < ($appointment_datetime - 86400)): ?>
                                                <a href="?cancel_appointment=<?= $appointment['appointment_id'] ?>" 
                                                   onclick="return confirm('Are you sure you want to cancel this appointment?')">
                                                   <button class="btn btn-primary ce5">Cancel Appointment</button>
                                                </a>
                                            <?php else: ?>
                                                <button class="btn btn-primary ce5" disabled>Cancel Unavailable</button>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    <?php else: ?>
                        <p style="text-align: center; font-size: 16px; color: #555; padding: 20px;">You have no upcoming appointments.</p>
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</section>

<?php include 'footer.php'; ?>