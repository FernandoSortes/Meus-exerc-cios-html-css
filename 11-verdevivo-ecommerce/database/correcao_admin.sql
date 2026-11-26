-- VerdeVivo - Correção da conta administrativa (Fernando)
-- Preserva os demais usuários, produtos e pedidos. Pode ser executado mais de uma vez.
-- ATENÇÃO: redefine a senha desta conta para 'fernando' (troque depois pelo sistema).
USE verdevivo;

-- 1) Se existir a conta antiga 'fernando@gmail' e a nova ainda não existir, migra a antiga (sem duplicar).
UPDATE users SET name='Fernando', email='fernando.sortes@outlook.com', password='$2y$10$xq5twm1I9oGcq1XkzNCJpOiJNShMgbEZEd1O9H6fk8wzeFwUIvQgq', role='admin'
 WHERE email='fernando@gmail'
   AND NOT EXISTS (SELECT 1 FROM (SELECT id FROM users WHERE email='fernando.sortes@outlook.com') t);

-- 2) Se ainda não existe nenhuma conta com o e-mail, cria.
INSERT INTO users (name,email,password,role)
SELECT 'Fernando','fernando.sortes@outlook.com','$2y$10$xq5twm1I9oGcq1XkzNCJpOiJNShMgbEZEd1O9H6fk8wzeFwUIvQgq','admin' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email='fernando.sortes@outlook.com');

-- 3) Garante nome, senha (hash bcrypt de password_hash) e perfil de administrador.
UPDATE users SET name='Fernando', password='$2y$10$xq5twm1I9oGcq1XkzNCJpOiJNShMgbEZEd1O9H6fk8wzeFwUIvQgq', role='admin' WHERE email='fernando.sortes@outlook.com';
