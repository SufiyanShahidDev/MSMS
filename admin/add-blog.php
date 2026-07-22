<?php
<<<<<<< HEAD

include '../dbconnect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $title = trim($_POST['title']);
    $category = trim($_POST['category']);
    $content = trim($_POST['content']);
    $tags = trim($_POST['tags']);

    $target_dir = "../images/blog/";
    $imagePath = "";

    // Upload image
    if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {

        // Create folder if it doesn't exist
        if (!is_dir($target_dir)) {
            mkdir($target_dir, 0777, true);
        }

        $fileName = time() . "_" . basename($_FILES['image']['name']);
        $target_file = $target_dir . $fileName;

        $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

        // Check if file is an image
        $check = getimagesize($_FILES['image']['tmp_name']);
        if ($check === false) {
            echo "<script>
                    alert('Selected file is not an image.');
                    window.location.href='manage-blog.php';
                  </script>";
            exit;
        }

        // Maximum file size (5 MB)
        if ($_FILES['image']['size'] > 5000000) {
            echo "<script>
                    alert('Image size must be less than 5MB.');
                    window.location.href='manage-blog.php';
                  </script>";
            exit;
        }

        // Allowed extensions
        $allowed = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

        if (!in_array($imageFileType, $allowed)) {
            echo "<script>
                    alert('Only JPG, JPEG, PNG, GIF and WEBP images are allowed.');
                    window.location.href='manage-blog.php';
                  </script>";
            exit;
        }

        if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
            $imagePath = "images/blog/" . $fileName;
        } else {
            echo "<script>
                    alert('Failed to upload image.');
                    window.location.href='manage-blog.php';
                  </script>";
            exit;
        }
    }

    try {

        $stmt = $pdo->prepare("
            INSERT INTO blog
            (title, content, image, post_date, category, tags)
            VALUES
            (:title, :content, :image, CURDATE(), :category, :tags)
        ");

        $stmt->execute([
            ':title'    => $title,
            ':content'  => $content,
            ':image'    => $imagePath,
            ':category' => $category,
            ':tags'     => $tags
        ]);

        echo "<script>
                alert('Blog added successfully!');
                window.location.href='manage-blog.php';
              </script>";
    } catch (PDOException $e) {

        echo "<script>
                alert('Failed to add blog: " . addslashes($e->getMessage()) . "');
                window.location.href='manage-blog.php';
              </script>";
    }
} else {

    echo "<script>
            alert('Invalid request!');
            window.location.href='manage-blog.php';
          </script>";
}
=======
include '../dbconnect.php';
require '../vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use Dotenv\Dotenv;

$dotenv = Dotenv::createImmutable(__DIR__ . '/../');
$dotenv->load();

// Function to send blog notification email to multiple recipients
function sendBlogNotificationEmail($title, $content, $tags, $subscribers) {
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

        // Add all subscriber emails
        foreach ($subscribers as $subscriber) {
            $mail->addAddress($subscriber['email']);
        }

        $mail->isHTML(true);
        $mail->Subject = 'New Blog Post: ' . $title;
        $mail->Body = "<h2>New Blog Post Published</h2>
                       <p><strong>$title</strong></p>
                       <p>$content</p>
                       <p>Tags: $tags</p>
                       <p>Check out the latest blog post on Glamour Salon!</p>";

        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = $_POST['title'];
    $category = $_POST['category'];
    $content = $_POST['content'];
    $tags = $_POST['tags'];
    
    $target_dir = "../images/blog/";
    $imagePath = '';

    if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
        $image = $_FILES['image'];
        $imagePath = $target_dir . basename($image['name']);
        move_uploaded_file($image['tmp_name'], $imagePath);
        $imagePath = 'images/blog/' . basename($image['name']);
    }

    try {
        // Insert the blog post including the image, category, and tags
        $stmt = $pdo->prepare("INSERT INTO blog (title, content, image, post_date, category, tags) VALUES (:title, :content, :image, CURDATE(), :category, :tags)");
        $stmt->execute(['title' => $title, 'content' => $content, 'image' => $imagePath, 'category' => $category, 'tags' => $tags]);

        // Fetch all emails from newsletter_subscribers table
        $stmt_subscribers = $pdo->prepare("SELECT email FROM newsletter_subscribers");
        $stmt_subscribers->execute();
        $subscribers = $stmt_subscribers->fetchAll(PDO::FETCH_ASSOC);

        if (sendBlogNotificationEmail($title, $content, $tags, $subscribers)) {
            header('Location: manage-blog.php?added=success');
        } else {
            header('Location: manage-blog.php?added=success&mail=failed');
        }
    } catch (Exception $e) {
        header('Location: manage-blog.php?added=error');
    }
    exit;
}
>>>>>>> 04935bc81071c5e9fc57decdaf1a94d54e7389f5
