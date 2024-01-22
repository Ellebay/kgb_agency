<?php
session_start();

require_once __DIR__ . '/../../../vendor/autoload.php'; 
require_once __DIR__ . '/../../model/Specialty.php';

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
        $specialty_data = json_decode(file_get_contents('php://input'), true);
        // Check if the specialty ID is provided
        if (isset($specialty_data['id_specialty'])) {
            $specialtyId = $specialty_data['id_specialty'];
            $result = Specialty::modifySpecialty($pdo, [
                'type' => $specialty_data['specialty_type'],
                'codeName' => $specialty_data['specialty_code_name']
            ], $specialtyId);

            // Renvoie la réponse au format JSON
            header('Content-Type: application/json');
            echo json_encode($result);

        } else {
            // No specialty ID provided
            header('Content-Type: application/json');
            echo json_encode(['message' => 'No specialty ID provided']);
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