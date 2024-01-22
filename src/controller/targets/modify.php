<?php
session_start();

require_once __DIR__ . '/../../../vendor/autoload.php'; 
require_once __DIR__ . '/../../model/Target.php';

if (file_exists(__DIR__ . '/../../../' . '/.env')) {
  $dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../../../');
  $dotenv->load();
}

$dsn = "mysql:host={$_ENV["STACKHERO_MYSQL_HOST"]};dbname={$_ENV["STACKHERO_MYSQL_NAME"]}";
  $options = array(
    PDO::MYSQL_ATTR_SSL_CAPATH => '/etc/ssl/certs/',
    PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => true,
  );

try {
    // Connect to the database
    /* $pdo = new PDO($dsn, $_ENV["DB_USERNAME"], $_ENV["DB_PASSWORD"]); */
    $pdo = new PDO($dsn, $_ENV["STACKHERO_MYSQL_USER"], $_ENV["STACKHERO_MYSQL_PASSWORD"], $options);
  $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Check if the request method is UPDATE
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $target_data = json_decode(file_get_contents('php://input'), true);
        // Check if the target ID is provided
        if (isset($target_data['id_target'])) {
            $targetId = $target_data['id_target'];
            $result = Target::modifyTarget($pdo, [
                'firstName' => $target_data['target_first_name'],
                'lastName' => $target_data['target_last_name'],
                'birthDate' => $target_data['target_birth_date'],
                'codeName' => $target_data['target_code_name'],
                'nationality' => $target_data['target_nationality']
            ], $targetId);

            // Renvoie la réponse au format JSON
            header('Content-Type: application/json');
            echo json_encode($result);

        } else {
            // No target ID provided
            header('Content-Type: application/json');
            echo json_encode(['message' => 'No target ID provided']);
            exit;
        }
    } else {
        // Invalid request method
        header('Content-Type: application/json');
        echo json_encode(['message' => 'Invalid request method']);
        exit;
    }

} catch (PDOException $e) {
    // Handle database connection error
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Database connection error: ' . $e->getMessage()]);
    exit;
}