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

// Fetch the logged-in user's data
$user_id = $_SESSION['user_id'];
$stmt_user = $pdo->prepare("SELECT * FROM users WHERE user_id = :user_id");
$stmt_user->execute(['user_id' => $user_id]);
$user = $stmt_user->fetch(PDO::FETCH_ASSOC);

<<<<<<< HEAD
$message = '';
$message_type = '';

function assignRandomStaff($pdo, $appointment_date, $appointment_time, $service_duration)
{
=======
// Function to send email after successful booking
function sendAppointmentEmail($email, $name, $appointment_date, $appointment_time, $service_name) {
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
        $mail->Subject = 'Your Appointment Confirmation';
        $mail->Body = "Dear $name,<br><br>Your appointment for $service_name on <b>$appointment_date</b> at <b>$appointment_time</b> has been successfully booked.<br><br>We look forward to seeing you at Glamour Salon.<br><br>Best regards,<br>Glamour Salon Team";

        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}

// Function to assign a random staff member if not selected
function assignRandomStaff($pdo, $appointment_date, $appointment_time, $service_duration) {
    // Get a random staff member who is available for the selected time and date
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    $stmt_random_staff = $pdo->prepare("
        SELECT user_id 
        FROM users 
        WHERE role = 'staff'
        AND user_id NOT IN (
            SELECT staff_id FROM appointments 
            WHERE appointment_date = :appointment_date 
            AND (
                :appointment_start_time BETWEEN appointment_time AND ADDTIME(appointment_time, SEC_TO_TIME(:service_duration * 60))
                OR 
                ADDTIME(:appointment_start_time, SEC_TO_TIME(:service_duration * 60)) BETWEEN appointment_time AND ADDTIME(appointment_time, SEC_TO_TIME(:service_duration * 60))
            )
        )
        ORDER BY RAND() LIMIT 1
    ");
<<<<<<< HEAD

=======
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    $stmt_random_staff->execute([
        'appointment_date' => $appointment_date,
        'appointment_start_time' => $appointment_time,
        'service_duration' => $service_duration
    ]);

    $staff = $stmt_random_staff->fetch(PDO::FETCH_ASSOC);
    return $staff ? $staff['user_id'] : null;
}

<<<<<<< HEAD
function isStaffAvailable($pdo, $staff_id, $appointment_date, $appointment_time, $service_duration)
{
=======
// Function to check if the selected staff is available
function isStaffAvailable($pdo, $staff_id, $appointment_date, $appointment_time, $service_duration) {
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    $stmt_check = $pdo->prepare("
        SELECT COUNT(*) as appointment_count 
        FROM appointments 
        WHERE staff_id = :staff_id 
        AND appointment_date = :appointment_date 
        AND (
            :appointment_start_time BETWEEN appointment_time AND ADDTIME(appointment_time, SEC_TO_TIME(:service_duration * 60))
            OR 
            ADDTIME(:appointment_start_time, SEC_TO_TIME(:service_duration * 60)) BETWEEN appointment_time AND ADDTIME(appointment_time, SEC_TO_TIME(:service_duration * 60))
        )
    ");
<<<<<<< HEAD

=======
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    $stmt_check->execute([
        'staff_id' => $staff_id,
        'appointment_date' => $appointment_date,
        'appointment_start_time' => $appointment_time,
        'service_duration' => $service_duration
    ]);

    $result = $stmt_check->fetch(PDO::FETCH_ASSOC);
    return $result['appointment_count'] == 0;
}

<<<<<<< HEAD
=======
// Form submission logic
$message = '';
$message_type = ''; // Variable to store message type (success or danger)

>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $service_id = $_POST['service'];
<<<<<<< HEAD

    $input_date = $_POST['date'];
    $date_object = DateTime::createFromFormat('d/m/Y', $input_date);

=======
    
    // Convert the user input date (assumed to be in dd/mm/yyyy) to the required format Y-m-d
    $input_date = $_POST['date'];
    $date_object = DateTime::createFromFormat('d/m/Y', $input_date);
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
    if ($date_object === false) {
        $message = "Invalid date format. Please use dd/mm/yyyy.";
        $message_type = 'danger';
    } else {
        $appointment_date = $date_object->format('Y-m-d');
<<<<<<< HEAD
        $appointment_time = date('H:i:s', strtotime($_POST['time']));

        $stmt_service = $pdo->prepare("SELECT name, duration FROM services WHERE service_id = :service_id");
        $stmt_service->execute(['service_id' => $service_id]);
        $service = $stmt_service->fetch(PDO::FETCH_ASSOC);

        if (!$service) {
            $message = "Invalid service selected.";
            $message_type = 'danger';
        } else {
            $service_duration = $service['duration'];
            $service_name = $service['name'];

            $staff_id = isset($_POST['staff']) && !empty($_POST['staff'])
                ? $_POST['staff']
                : assignRandomStaff($pdo, $appointment_date, $appointment_time, $service_duration);

            if (!$staff_id) {
                $message = "Sorry, no staff member is available for the selected time.";
                $message_type = 'danger';
            } elseif (!isStaffAvailable($pdo, $staff_id, $appointment_date, $appointment_time, $service_duration)) {
                $message = "Sorry, the selected staff member is not available for this time slot.";
                $message_type = 'danger';
            } else {
                $stmt = $pdo->prepare("
                    INSERT INTO appointments (user_id, name, email, phone, service_id, staff_id, appointment_date, appointment_time) 
                    VALUES (:user_id, :name, :email, :phone, :service_id, :staff_id, :appointment_date, :appointment_time)
                ");

                $stmt->execute([
                    'user_id' => $user_id,
                    'name' => $name,
                    'email' => $email,
                    'phone' => $phone,
                    'service_id' => $service_id,
                    'staff_id' => $staff_id,
                    'appointment_date' => $appointment_date,
                    'appointment_time' => $appointment_time
                ]);

                $message = "Appointment successfully booked!";
                $message_type = 'success';
            }
=======
    }

    $appointment_time = date('H:i:s', strtotime($_POST['time']));

    // Get the service duration from the services table
    $stmt_service = $pdo->prepare("SELECT name, duration FROM services WHERE service_id = :service_id");
    $stmt_service->execute(['service_id' => $service_id]);
    $service = $stmt_service->fetch(PDO::FETCH_ASSOC);
    
    if (!$service) {
        $message = "Invalid service selected.";
        $message_type = 'danger';
    } else {
        // Calculate appointment end time based on service duration
        $service_duration = $service['duration'];
        $service_name = $service['name'];
        
        // Check if the user selected a staff member
        $staff_id = isset($_POST['staff']) && !empty($_POST['staff']) ? $_POST['staff'] : assignRandomStaff($pdo, $appointment_date, $appointment_time, $service_duration); // Assign a random staff member if none selected
        
        if (!$staff_id) {
            $message = "Sorry, no staff member is available for the selected time.";
            $message_type = 'danger';
        } elseif (!isStaffAvailable($pdo, $staff_id, $appointment_date, $appointment_time, $service_duration)) {
            $message = "Sorry, the selected staff member is not available for this time slot.";
            $message_type = 'danger';
        } else {
            // Insert appointment into the database
            $stmt = $pdo->prepare("
                INSERT INTO appointments (user_id, name, email, phone, service_id, staff_id, appointment_date, appointment_time) 
                VALUES (:user_id, :name, :email, :phone, :service_id, :staff_id, :appointment_date, :appointment_time)
            ");
            $stmt->execute([
                'user_id' => $user_id,
                'name' => $name,
                'email' => $email,
                'phone' => $phone,
                'service_id' => $service_id,
                'staff_id' => $staff_id,
                'appointment_date' => $appointment_date,
                'appointment_time' => $appointment_time
            ]);

            // Send email after successful appointment booking
            if (sendAppointmentEmail($email, $name, $appointment_date, $appointment_time, $service_name)) {
                $message = "Appointment successfully booked and confirmation email sent!";
            } else {
                $message = "Appointment booked, but failed to send confirmation email.";
            }
            $message_type = 'success';
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
        }
    }
}
?>

<section class="breadcrumbs-area ptb-100">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <div class="breadcrumbs">
                    <h2 class="page-title">Appointment</h2>
                    <ul>
<<<<<<< HEAD
                        <li><a class="active" href="index.php">Home</a></li>
=======
                        <li>
                            <a class="active" href="index.php">Home</a>
                        </li>
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                        <li>Appointment</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="hs-appoinment-area" class="hs-appoinment-area bg-gray">
    <div class="container-fluid ps-0 pe-0">
        <div class="row g-0 align-items-center">
            <div class="col-lg-6">
                <div class="appoinment-thumb appoinment-thumb-st2">
                    <img src="images/others/appoinment/1.jpg" alt="appointment image">
                </div>
            </div>

            <div class="col-lg-6">
                <div class="appoinment-inner appoinment-inner-st2">
                    <div class="appoinment-title text-center">
                        <h2 class="section-title">Book an Appointment</h2>
                        <p class="section-details appoinment">
<<<<<<< HEAD
                            Schedule your beauty experience with Signature Men's Salon. Fill in the details below and we will take care of the rest.
=======
                            Schedule your beauty experience with Glamour Salon. Fill in the details below and we will take care of the rest.
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                        </p>
                    </div>

                    <?php if ($message): ?>
                        <br>
                        <div class="alert alert-<?= $message_type ?> text-center">
                            <?= $message ?>
                        </div>
                    <?php endif; ?>

                    <div class="appoinment-form mt-40">
<<<<<<< HEAD
                        <form action="" method="POST">
                            <div class="input-box">
                                <input type="text" name="name" value="<?= htmlspecialchars($user['first_name'] . ' ' . $user['last_name']) ?>" readonly required>
                                <input type="email" name="email" value="<?= htmlspecialchars($user['email']) ?>" readonly required>
                            </div>

                            <div class="input-box">
                                <input type="tel" name="phone" value="<?= htmlspecialchars($user['telephone']) ?>" readonly required>
=======
                        <form action="appointment.php" method="POST">
                            <div class="input-box">
                                <input type="text" name="name" value="<?= $user['first_name'] . ' ' . $user['last_name'] ?>" readonly required>
                                <input type="email" name="email" value="<?= $user['email'] ?>" readonly required>
                            </div>
                            <div class="input-box">
                                <input type="tel" name="phone" value="<?= $user['telephone'] ?>" readonly required>
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                                <select name="service" required>
                                    <option disabled selected>Choose Service</option>
                                    <?php
                                    $stmt_services = $pdo->prepare("SELECT service_id, name FROM services");
                                    $stmt_services->execute();
                                    $services = $stmt_services->fetchAll(PDO::FETCH_ASSOC);
                                    foreach ($services as $service): ?>
<<<<<<< HEAD
                                        <option value="<?= $service['service_id'] ?>"><?= htmlspecialchars($service['name']) ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

=======
                                        <option value="<?= $service['service_id'] ?>"><?= $service['name'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                            <div class="input-box">
                                <input type="text" id="datepicker" name="date" placeholder="Preferred Date" required>
                                <select name="time" id="time-select" required>
                                    <option disabled selected>Choose Time</option>
<<<<<<< HEAD
                                    <option value="09:00:00">09:00 AM</option>
                                    <option value="09:30:00">09:30 AM</option>
                                    <option value="10:00:00">10:00 AM</option>
                                    <option value="10:30:00">10:30 AM</option>
                                    <option value="11:00:00">11:00 AM</option>
                                    <option value="11:30:00">11:30 AM</option>
                                    <option value="12:00:00">12:00 PM</option>
                                    <option value="12:30:00">12:30 PM</option>
                                    <option value="13:00:00">01:00 PM</option>
                                    <option value="13:30:00">01:30 PM</option>
                                    <option value="14:00:00">02:00 PM</option>
                                    <option value="14:30:00">02:30 PM</option>
                                    <option value="15:00:00">03:00 PM</option>
                                    <option value="15:30:00">03:30 PM</option>
                                    <option value="16:00:00">04:00 PM</option>
                                    <option value="16:30:00">04:30 PM</option>
                                    <option value="17:00:00">05:00 PM</option>
                                    <option value="17:30:00">05:30 PM</option>
                                    <option value="18:00:00">06:00 PM</option>
                                    <option value="18:30:00">06:30 PM</option>
                                    <option value="19:00:00">07:00 PM</option>
                                    <option value="19:30:00">07:30 PM</option>
                                    <option value="20:00:00">08:00 PM</option>
                                </select>
                            </div>

=======
                                </select>
                            </div>
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                            <div style="border: 1px solid transparent; color: #000000; font-family: Lato; font-size: 14px; font-weight: 400; padding-left: 0px; line-height: 45px; margin-top: 18px;">
                                <select name="staff" style="border: 1px solid #000000; width: 100%; height: 45px; padding-left: 20px;">
                                    <option value="">Select Staff Member (Optional)</option>
                                    <?php
                                    $stmt_staff = $pdo->prepare("SELECT user_id, CONCAT(first_name, ' ', last_name) as staff_name FROM users WHERE role = 'staff'");
                                    $stmt_staff->execute();
                                    $staff_members = $stmt_staff->fetchAll(PDO::FETCH_ASSOC);
                                    foreach ($staff_members as $staff): ?>
<<<<<<< HEAD
                                        <option value="<?= $staff['user_id'] ?>"><?= htmlspecialchars($staff['staff_name']) ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

=======
                                        <option value="<?= $staff['user_id'] ?>"><?= $staff['staff_name'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
                            <div class="book-appoin-btn mt-30">
                                <button type="submit" class="hs-btn hs-btn-2">Book Now</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<?php include 'footer.php'; ?>