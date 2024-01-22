<?php
session_start();

require_once __DIR__ . '/../../../vendor/autoload.php'; 
require_once __DIR__ . '/../../model/Mission.php';

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

    // POST request for updating data
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $mission_data = json_decode(file_get_contents('php://input'), true);

        // Check if the agent ID is provided
        if (isset($mission_data['id_mission'])) {
            $missionId = $mission_data['id_mission'];
            $hideoutId = $mission_data['id_hideout'];
            $agentIds = $mission_data['id_agent'];
            $contactIds = $mission_data['id_contact'];
            $targetIds = $mission_data['id_target'];
            $specialtyId = $mission_data['id_specialty'];

            $result = Mission::modifyMission($pdo, [
                'title' => $mission_data['mission_title'],
                'codeName' => $mission_data['mission_code_name'],
                'statut' => $mission_data['mission_statut'],
                'description' => $mission_data['mission_description'],
                'country' => $mission_data['mission_country'],
                'type' => $mission_data['mission_type'],
                'specialization' => $mission_data['id_specialty'],
                'startDate' => $mission_data['mission_start_date'],
                'endDate' => $mission_data['mission_end_date']
            ], $missionId, $agentIds, $contactIds, $targetIds, $hideoutId);

            // Renvoie la réponse au format JSON
            header('Content-Type: application/json');
            echo json_encode($result);

        } else {
            // No agent ID provided
            header('Content-Type: application/json');
            echo json_encode(['message' => 'No mission ID provided']);
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