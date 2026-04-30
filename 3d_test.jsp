<html>
<head>
    <script src="https://unpkg.com/three@0.141.0/build/three.min.js"></script>
    <script src="https://unpkg.com/three@0.141.0/examples/js/controls/OrbitControls.js"></script>
    <script src="https://unpkg.com/three@0.141.0/examples/js/loaders/GLTFLoader.js"></script>
</head>
<body>
    <canvas id="canvas" width="600" height="600"></canvas>
    <script>
        // 씬, 카메라, 렌더러 설정
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, 1, 0.1, 1000);
        camera.position.set(0, 2, 5);

        const renderer = new THREE.WebGLRenderer({ canvas: document.getElementById('canvas') });
        renderer.setSize(1200, 1200);
        renderer.setClearColor(0xffffff); // 배경 색상 설정

        // OrbitControls
        const controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;
        controls.dampingFactor = 0.1;

        // 조명 설정
        const light = new THREE.DirectionalLight(0xffffff, 1);
        light.position.set(5, 5, 5);
        scene.add(light);

        const ambientLight = new THREE.AmbientLight(0x404040, 1.5); // 부드러운 조명
        scene.add(ambientLight);

        // 컵케이크 모델 로드
        const loader = new THREE.GLTFLoader();
        loader.load(
            '/onlycake/object/cupcake.gltf', // 실제 경로에 맞게 업데이트
            function (gltf) {
                scene.add(gltf.scene);
                // 컵케이크 다음에 크림 모델 로드
                loadCreamModel(gltf.scene);
            },
            undefined,
            function (error) {
                console.error('컵케이크 모델 로드 중 오류 발생:', error);
            }
        );

        // 크림 모델 로드
        function loadCreamModel(cupcakeScene) {
            loader.load(
                '/onlycake/object/cream.gltf', // 실제 경로에 맞게 업데이트
                function (gltf) {
                    // 크림 모델을 컵케이크 위에 위치 설정
                    gltf.scene.position.set(0, 0, 0); // 필요에 따라 Y 값을 조정
                    cupcakeScene.add(gltf.scene);
                },
                undefined,
                function (error) {
                    console.error('크림 모델 로드 중 오류 발생:', error);
                }
            );
        }

        // 애니메이션 루프
        function animate() {
            requestAnimationFrame(animate);
            controls.update();
            renderer.render(scene, camera);
        }
        animate();
    </script>
</body>
</html>
