// --- THREE.JS SETUP ---
const container = document.getElementById('canvas-container');
const scene = new THREE.Scene();
// Fog for depth (Deep Purple Glow)
scene.fog = new THREE.FogExp2(0x0B0B0E, 0.002);

const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 2000);
const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setPixelRatio(window.devicePixelRatio);
container.appendChild(renderer.domElement);

// --- TEXTURE GENERATION ---
function getTexture() {
    const canvas = document.createElement('canvas');
    canvas.width = 32;
    canvas.height = 32;
    const context = canvas.getContext('2d');
    const gradient = context.createRadialGradient(16, 16, 0, 16, 16, 16);
    gradient.addColorStop(0, 'rgba(255,255,255,1)');
    gradient.addColorStop(1, 'rgba(255,255,255,0)');
    context.fillStyle = gradient;
    context.fillRect(0, 0, 32, 32);
    const texture = new THREE.CanvasTexture(canvas);
    return texture;
}

const particleTexture = getTexture();

// --- PARTICLES (THE GALAXY) ---

const createStarField = (count, color, size, spread) => {
    const geometry = new THREE.BufferGeometry();
    const vertices = [];

    for (let i = 0; i < count; i++) {
        const x = (Math.random() - 0.5) * spread;
        const y = (Math.random() - 0.5) * spread;
        const z = (Math.random() - 0.5) * spread;
        vertices.push(x, y, z);
    }

    geometry.setAttribute('position', new THREE.Float32BufferAttribute(vertices, 3));

    const material = new THREE.PointsMaterial({
        color: color,
        size: size,
        map: particleTexture,
        transparent: true,
        opacity: 0.8,
        sizeAttenuation: true,
        depthWrite: false
    });

    return new THREE.Points(geometry, material);
};

// 1. Background Dust (Silver/White)
const stars = createStarField(5000, 0xFFFFFF, 0.8, 2000);
scene.add(stars);

// 2. The Core Nexus (Neon Pink) - A spiral shape
const coreGeometry = new THREE.BufferGeometry();
const coreVertices = [];
const coreCount = 4000;

for(let i=0; i<coreCount; i++) {
    const angle = i * 0.02;
    const radius = 5 + (i * 0.1);
    const x = Math.cos(angle) * radius + (Math.random() - 0.5) * 5;
    const y = (Math.random() - 0.5) * 40;
    const z = Math.sin(angle) * radius + (Math.random() - 0.5) * 5;
    coreVertices.push(x, y, z);
}

coreGeometry.setAttribute('position', new THREE.Float32BufferAttribute(coreVertices, 3));
const coreMaterial = new THREE.PointsMaterial({
    color: 0xFF006E, // PRIMARY COLOR
    size: 1.5,
    map: particleTexture,
    transparent: true,
    opacity: 0.9,
    blending: THREE.AdditiveBlending,
    depthWrite: false
});
const nexusCore = new THREE.Points(coreGeometry, coreMaterial);
scene.add(nexusCore);

// 3. Ambient Glow Orbs (Purple)
const glowGeometry = new THREE.BufferGeometry();
const glowVertices = [];
for(let i=0; i<20; i++) {
    glowVertices.push(
        (Math.random()-0.5)*800,
        (Math.random()-0.5)*800,
        (Math.random()-0.5)*800
    );
}
glowGeometry.setAttribute('position', new THREE.Float32BufferAttribute(glowVertices, 3));
const glowMaterial = new THREE.PointsMaterial({
    color: 0x310D3D, // AMBIENT GLOW
    size: 200,
    map: particleTexture,
    transparent: true,
    opacity: 0.4,
    blending: THREE.AdditiveBlending,
    depthWrite: false
});
const glowOrbs = new THREE.Points(glowGeometry, glowMaterial);
scene.add(glowOrbs);


camera.position.z = 400;

// --- ANIMATION LOOP ---
let mouseX = 0;
let mouseY = 0;

document.addEventListener('mousemove', (e) => {
    mouseX = (e.clientX - window.innerWidth / 2) * 0.5;
    mouseY = (e.clientY - window.innerHeight / 2) * 0.5;
});

const clock = new THREE.Clock();

function animate() {
    const time = clock.getElapsedTime();

    nexusCore.rotation.y += 0.002;
    nexusCore.rotation.z += 0.001;

    const scale = 1 + Math.sin(time) * 0.05;
    nexusCore.scale.set(scale, scale, scale);

    stars.rotation.y -= 0.0005;

    camera.position.x += (mouseX - camera.position.x) * 0.02;
    camera.position.y += (-mouseY - camera.position.y) * 0.02;

    camera.lookAt(scene.position);

    renderer.render(scene, camera);
    requestAnimationFrame(animate);
}

animate();

// --- RESIZE HANDLER ---
window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
});